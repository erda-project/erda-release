// Copyright (c) 2021 Terminus, Inc.
//
// This program is free software: you can use, redistribute, and/or modify
// it under the terms of the GNU Affero General Public License, version 3
// or later ("AGPL"), as published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
package main

import (
	"context"
	"fmt"
	"io/ioutil"
	v1 "k8s.io/api/core/v1"
	"k8s.io/apimachinery/pkg/api/errors"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/rest"
	"os"
	"os/exec"
	"sigs.k8s.io/yaml"
	"time"
)

func main() {
	// creates the in-cluster config
	config, err := rest.InClusterConfig()
	if err != nil {
		panic(err.Error())
	}
	// creates the clientset
	clientset, err := kubernetes.NewForConfig(config)
	if err != nil {
		panic(err.Error())
	}

	if err = createSecretsFile(); err != nil {
		fmt.Printf("Error: %v\n", err)
		panic(err.Error())
	}

	createEtcdSecretsByK8sClient(clientset, "./etcd-server-secret.yaml")
	createEtcdSecretsByK8sClient(clientset, "./etcd-client-secret.yaml")
}

func createSecretsFile() error {
	ctx, calcel := context.WithTimeout(context.Background(), 30*time.Second)
	defer calcel()

	cmd := exec.CommandContext(ctx, "./generate_ssl.sh")
	err := cmd.Start()
	if err != nil {
		panic(err.Error())
	}
	fmt.Printf("Waiting for generate ssl files for etcd...\n")
	err = cmd.Wait()
	return err

}

func createEtcdSecretsByK8sClient(cli *kubernetes.Clientset, filename string) {
	_, err := os.Stat(filename)
	if err != nil {
		if os.IsNotExist(err) {
			fmt.Printf("Error creating etcd secrets: file %s not exist.\n", filename)
			panic(err.Error())
		} else {
			fmt.Printf("Error creating etcd secrets: %v.\n", err)
			panic(err.Error())
		}
	}

	yamlFile, err := ioutil.ReadFile(filename)
	if err != nil {
		fmt.Println(err.Error())
		panic(err.Error())
	}
	var secret v1.Secret

	err = yaml.Unmarshal(yamlFile, &secret)
	if err != nil {
		fmt.Println(err.Error())
		panic(err.Error())
	}

	_, err = cli.CoreV1().Secrets(secret.Namespace).Get(context.TODO(), secret.Name, metav1.GetOptions{})
	if err == nil {
		fmt.Printf("Secret %s has existed in namespace %s, will update it \n", secret.Name, secret.Namespace)
		_, err = cli.CoreV1().Secrets(secret.Namespace).Update(context.TODO(), &secret, metav1.UpdateOptions{})
		if err == nil {
			fmt.Printf("Create secret %s in namespace %s by file %s successfully (by updating).\n", secret.Name, secret.Namespace, filename)
		} else {
			fmt.Printf("Secret %s has existed in namespace %s, updating it failed, will delete and re-create it.\n", secret.Name, secret.Namespace)
			err = cli.CoreV1().Secrets(secret.Namespace).Delete(context.TODO(), secret.Name, metav1.DeleteOptions{})
			if err != nil {
				fmt.Printf("Secret %s has existed in namespace %s, Delete it failed： %v.\n", secret.Name, secret.Namespace, err)
				panic(err.Error())
			} else {
				_, err = cli.CoreV1().Secrets(secret.Namespace).Create(context.TODO(), &secret, metav1.CreateOptions{})
				if err != nil {
					panic(err.Error())
				}
				fmt.Printf("Create secret %s in namespace %s by file %s successfully.\n", secret.Name, secret.Namespace, filename)
			}
		}
	} else {
		if errors.IsNotFound(err) {
			_, err = cli.CoreV1().Secrets(secret.Namespace).Create(context.TODO(), &secret, metav1.CreateOptions{})
			if err != nil {
				panic(err.Error())
			}
			fmt.Printf("Create secret %s in namespace %s by file %s successfully.\n", secret.Name, secret.Namespace, filename)
		} else if err != nil {
			panic(fmt.Errorf("Error creating etcd secrets: can not detect secret %s in namespace %s exist or not", secret.Name, secret.Namespace).Error())
		}
	}
}
