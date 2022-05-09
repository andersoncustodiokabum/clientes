# Clientes

## Clonar Projeto
    git clone https://github.com/andersoncustodiokabum/clientes.git

## Iniciar Container
    docker-compose up

## Importar Banco de Dados
    docker-compose exec -T mysql mysql -proot clientes < db/clientes.sql