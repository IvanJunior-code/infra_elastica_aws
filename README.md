
# Terraform Load Balancer Test Project

Este projeto tem como objetivo testar e demonstrar a configuração de um Load Balancer na AWS utilizando Terraform. O Load Balancer faz o direcionamento do tráfego para instâncias EC2, que são criadas através de um Autoscaling Group que utiliza um Template de máquinas. O objetivo principal é aplicar conceitos de infraestrutura como código (IaC) para uma infraestrutura com Load Balancer.

</br>

## Objetivo

O objetivo principal deste repositório é testar e demonstrar como configurar um Load Balancer na AWS usando Terraform para distribuir tráfego entre instâncias EC2. O estudo inclui:

- Criação de um Application Load Balancer (ALB).
- Configuração de listeners e regras de roteamento de tráfego.
- Criação de instâncias EC2 com um servidor web configurado.
- Validação do balanceamento de carga com página agregada no servidor Nginx.


</br>

## Tecnologias Utilizadas

- **Terraform**: Para provisionar os recursos de infraestrutura na AWS.
- **AWS**: Para criar e gerenciar os recursos como EC2, ALB, e Security Groups.
- **Nginx**: Para servir a página HTML de teste em cada instância criada.


</br>

## Pré requisito

- Conta AWS configurada.
- Terraform instalado.
- Credenciais da AWS configuradas (aws configure).
- Chave SSH criada e registrada na AWS para acesso às instâncias EC2.


<br>

## Estrutura do Projeto

- Diretório `infra`: Contém toda a infraestrutura do projeto que pode ser utilizada como modulo.
- Diretório `env`: Contém subdiretórios, podendo ser cada um deles um ambiente diferente.
- `provider.tf`: Configuração do provedor AWS.
- `main.tf`: Configuração principal para criar o ALB, listeners, Autoscaling Group, Autoscaling Policy, Target Group, default VPC e subnets, e Launch Template.
- `variables.tf`: Definição de variáveis utilizadas no projeto.
- `outputs.tf`: Saídas do Terraform identificando os recursos criados.


<br>

## Exemplo de uso

1. Configurar as Variáveis:
Edite o arquivo `terraform.tfvars` para configurar as variáveis, como `key_name` e `path_key`.

**Nota**: Em caso de configuração de um novo ambiente utilizando a modularização, se faz necessário especificar valores para as variáveis `key_name`, `path_key`, `environment`, `max_size`, `min_size`, `prod`, bem como especificar `source = "../../infra"`.


2. Inicializar o Terraform no ambiente desejado:
```
terraform init
```

3. Aplicar a Configuração:
```
terraform apply
```
Confirme quando solicitado.

4. Testar os acessos:
- O output do ambiente especificado como produção (`prod = true`) exibe o endereço do Load Balancer após aplicar a IaC.
- O output de demais ambientes (`prod = false`) exibirão apenas a string de conexão ssh para as instâncias que foram criadas.

<br>

## Conclusão
Este projeto fornece um ambiente de teste para configurar uma infraestrutura elástica na AWS através da modularização com Terraform. Este projeto também contribui para o entendimento de como um Load Balancer funciona na AWS, contendo conceitos importantes de infraestrutura e provisionamento de recursos.