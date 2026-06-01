# Infraestructura en AWS con Terraform

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-009639?style=for-the-badge&logo=nginx&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)

Proyecto educativo que despliega una infraestructura basica en AWS usando **Terraform**. Levanta una VPC, subnets, routing, security group y un servidor EC2 con nginx — automatizado con GitHub Actions y estado remoto en S3.


## Como funciona el despliegue automatizado

El flujo end-to-end con un solo `terraform apply`:

1. Terraform lee [setup.sh](setup.sh) con la funcion `file()`
2. Lo inyecta como `user_data` en la EC2
3. AWS ejecuta el script en el primer boot de la instancia:
   - `apt install nginx`
   - escribe el HTML en `/var/www/html/index.html`
   - reinicia nginx
4. La pagina queda servida en `http://<IP_PUBLICA>`

## CI/CD con GitHub Actions

Hay dos workflows:

| Workflow | Archivo | Trigger | Que hace |
|----------|---------|---------|----------|
| Terraform CI/CD | [terraform.yml](.github/workflows/terraform.yml) | Push / PR a `main` | Plan en PRs, apply automatico al mergear a main |
| Terraform Destroy | [destoy.yml](.github/workflows/destoy.yml) | Manual (`workflow_dispatch`) | Destruye toda la infraestructura |

Ambos workflows usan el mismo grupo de concurrencia, por lo que nunca corren en paralelo y no pueden corromper el estado.

**Secrets requeridos en el repositorio** (`Settings -> Secrets and variables -> Actions`):

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

El estado de Terraform se guarda de forma remota en un bucket S3 (`terraform-state-godiano`), compartido entre la maquina local y GitHub Actions.

## Como usarlo localmente

**Requisitos:**
- Terraform instalado
- AWS CLI configurado (`aws configure`)
- Un key pair llamado `clave-servidor` creado en la consola de AWS (region `us-east-1`)

```bash
# Descarga el provider de AWS y conecta con el backend S3
terraform init

# Crea la infraestructura
terraform apply

# Destruye todo
terraform destroy
```

Despues del apply, obtén la IP publica en la consola AWS y abre `http://<IP>`

## Resultado

<img width="1470" height="929" alt="Screenshot 2026-05-23 at 3 07 21 AM" src="https://github.com/user-attachments/assets/82b36c5d-069b-40df-8e06-a3f4e7f3fbdd" />
