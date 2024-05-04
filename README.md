**Este projeto tem como objetivo analisar o dataset Netflix disponível na plataforma Kaggle. O dataset contém informações sobre filmes e séries disponíveis na plataforma Netflix, como título, data de adição, gênero, diretor, elenco, entre outros.**

*O dataset Netflix foi utilizado neste projeto. O dataset pode ser baixado na plataforma* **Kaggle**: *https://www.kaggle.com/datasets/syedmubarak/netflix-dataset-latest-2021*


*O dataset foi pré-processado e normalizado. As seguintes etapas foram realizadas:*

    -Conversão da coluna "DATE_ADDED" para o formato DATE: A coluna "DATE_ADDED" estava no formato "August 4, 2017", que não é  compatível com o tipo DATE no MySQL. Para converter a coluna para o formato DATE.

    -Conversão da coluna "RELEASE_YEAR" para o tipo INT: A coluna "RELEASE_YEAR" estava no tipo DATE na versão 1.0 do modelo físico. Para converter a coluna para o tipo INT.

    -Remoção do "s" da coluna "SHOW_ID": A coluna "SHOW_ID" tinha um "s" antes de todo o número do ID, removemos o "s" e mudamos o tipo da coluna para INT.

    -Conversão da coluna "TITLE" para o tipo STRING: A coluna "TITLE" tinha o tipo OBJECT, converter a coluna para o tipo STRING

    -Mudança de nome da coluna "TYPE" para "TYPE_SHOW": A coluna "TYPE" era uma palavra reservada do MySQL. Para evitar problemas, a coluna foi renomeada para "TYPE_SHOW" e o tipo da coluna foi alterado para STRING.

    -Coluna "DURATION" tinha letras e numeros dentro dela, e era dividida em minutos e seasons,tiramos todos os caracteres que nao fossem numericos de dentro dela e transformamos ela para INT

![Modelo_logico_netflix](https://github.com/wesleyruanwr/projeto_UFC/assets/119066770/0ce7ce80-7539-42d1-befd-5ad4387165f8)

*Também foram adicionados arquivos Dockerfile e Docker-compose para que a execução do processo possa ser feita em qualquer maquina, estão localizados na pasta* **Docker**

*Para realizarmos todo esse processo, nosso grupo utilizou metodologias ágeis e fizemos um ROADMAP para melhor acompanhamento.*
    *Link para o ROADMAP:* **https://miro.com/app/board/uXjVKRun7Dk=/**
