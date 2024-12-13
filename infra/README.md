
# Terraform Load Balancer Test Project

Este projeto tem como objetivo testar e demonstrar a configuração de um Load Balancer na AWS utilizando Terraform. O Load Balancer faz o direcionamento do tráfego para instâncias EC2, que são criadas através de um Autoscaling Group que utiliza um Template de máquinas. O objetivo principal é aplicar conceitos de infraestrutura como código (IaC) para uma infraestrutura com Load Balancer.

</br>

## Objetivo

O objetivo principal deste repositório é testar e demonstrar como configurar um Load Balancer na AWS usando Terraform para distribuir tráfego entre instâncias EC2. O estudo inclui:

Criação de um Application Load Balancer (ALB).
Configuração de listeners e regras de roteamento de tráfego.
Deploy de instâncias EC2 com um servidor web configurado para responder às requisições.
Validação do balanceamento de carga com páginas simples servidas pelo Nginx.


</br>

## Tecnologias Utilizadas

- **Terraform**: Para provisionar os recursos de infraestrutura na AWS.
- **AWS**: Para criar e gerenciar os recursos como EC2, ALB, e Security Groups.
- **Nginx**: Para servir uma página HTML simples em cada instância.


</br>

## Pré requisito

- Conta AWS configurada.
- Terraform instalado.
- Credenciais da AWS configuradas (via aws configure ou variáveis de ambiente).
- Chave SSH criada e registrada na AWS para acesso às instâncias EC2.


<br>

## Estrutura do Projeto

- `provider.tf`: Configuração do provedor AWS.
- `main.tf`: Configuração principal para criar o ALB, listeners e instâncias EC2.
- `variables.tf`: Definição de variáveis utilizadas no projeto.
- `outputs.tf`: Saídas do Terraform para identificar recursos criados.
- `files/`: Contém o arquivo HTML usado como página de teste.


<br>

## Exemplo de uso

1. Configurar as Variáveis:
Edite o arquivo variables.tf ou passe valores via linha de comando para configurar as variáveis, como tipo de instância, região e ID da imagem (AMI).

2. Inicializar o Terraform:
```
terraform init
```

3. Aplicar a Configuração:
```
terraform apply
```
Confirme quando solicitado. O Terraform criará o Load Balancer, instâncias EC2 e configurará o ambiente.

4. Testar o Balanceamento de Carga:
- Obtenha o DNS do Load Balancer no output do Terraform ou via AWS Management Console.
- Acesse o DNS do Load Balancer no navegador. Você verá uma página de teste simples servida por Nginx, confirmando que o balanceamento de carga está funcionando.

<br>

## Conclusão
Este projeto fornece um ambiente de teste para configurar e entender como um Load Balancer funciona na AWS utilizando Terraform. Ele demonstra conceitos importantes de infraestrutura como código, balanceamento de carga e automação no provisionamento de recursos.