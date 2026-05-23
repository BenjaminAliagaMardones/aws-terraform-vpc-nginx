# Infraestructura AWS con Terraform

Proyecto educativo que despliega una infraestructura básica en AWS usando **Terraform**. Levanta una VPC, subnets, routing, security group y un servidor EC2 con nginx — todo de forma automática con un solo comando.


## Cómo funciona el despliegue automatizado

El flujo end-to-end con un solo `terraform apply`:

1. Terraform lee [setup.sh](setup.sh) con la función `file()`
2. Lo inyecta como `user_data` en la EC2
3. AWS ejecuta el script en el primer boot de la instancia:
   - `apt install nginx`
   - escribe el HTML en `/var/www/html/index.html`
   - reinicia nginx
4. La página queda servida en `http://<IP_PUBLICA>`

## Cómo usarlo

**Requisitos:**
- Terraform instalado
- AWS CLI configurado (`aws configure`)
- Un key pair llamado `clave-servidor` creado en la consola de AWS (región `us-east-1`)

```bash
# Descarga el provider de AWS
terraform init

# Crea la infraestructura
terraform apply

# Destruye todo
terraform destroy
```

Después del apply, obtén la IP pública en la consola AWS y abre `http://<IP>`
