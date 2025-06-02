## Cats App

Um aplicativo iOS simples para explorar e visualizar imagens de gatos, obtidas de uma API externa. O aplicativo demonstra uma arquitetura MVVMC (Model-View-ViewModel-Coordinator) robusta e práticas modernas de desenvolvimento iOS.

---

## Funcionalidades

- Lista de Gatos: Exibe uma coleção infinita de imagens de gatos com seus respectivos rótulos (tags).
- Rolagem Infinita: Carrega mais gatos automaticamente conforme o usuário rola para baixo na lista.
- Tela de Detalhes: Ao tocar em uma imagem de gato na lista, o usuário é levado para uma tela de detalhes que exibe a imagem em tamanho maior, seu ID e tags associadas.
- Formatação de Datas: As datas de criação dos gatos são formatadas de uma string para um formato legível em inglês.
- Tags Dinâmicas: As tags na tela de detalhes são exibidas em um layout de "pílulas" que se ajustam e quebram linha automaticamente.
- Cache de Imagens: Imagens de gatos são cacheadas para carregamento rápido e eficiente.

---

## Arquitetura e Tecnologias Utilizadas

Este projeto foi construído seguindo os princípios de uma arquitetura limpa e organizada, utilizando os seguintes elementos:

### MVVMC (Model-View-ViewModel-Coordinator)

- Model: Representa os dados e a lógica de negócios.  
  Arquivo: `Cat.swift`

- View: Componentes da interface do usuário (UI) que exibem dados e reagem às interações do usuário.  
  Arquivos: 
  - `CatListViewController.swift`  
  - `CatCollectionViewCell.swift`  
  - `CatDetailsViewController.swift`

- ViewModel: Atua como uma camada intermediária entre a View e o Model, transformando dados do Model em algo que a View possa exibir e manipulando a lógica de apresentação.  
  Arquivos: 
  - `CatListViewModel.swift`  
  - `CatDetailsViewModel.swift`

- Coordinator: Gerencia o fluxo de navegação entre diferentes telas, desacoplando a lógica de navegação das ViewModels e ViewControllers.  
  Arquivo: `AppCoordinator.swift`

---

### Tecnologias

- UIKit: Framework da Apple para construir interfaces de usuário nativas em iOS.
- Auto Layout Programático: Todas as constraints de layout são definidas via código para maior controle e flexibilidade.
- URLSession: Utilizado para todas as operações de rede, como buscar a lista de gatos e suas imagens.
- NSCache: Implementado para cache de imagens em memória, melhorando a performance ao rolar a lista.
- DateFormatter: Utilizado para converter strings de data em objetos `Date` e formatá-los para exibição em um formato legível.
- Extensões Swift: Utilizadas para adicionar funcionalidades a tipos existentes de forma organizada.  
  Exemplos:
  - `UIImageView+Ext.swift` (carregamento de imagens)  
  - `URL+Ext.swift` (parâmetros de query)
- Lazy Initialization (`lazy var`): Utilizado para inicializar propriedades da UI apenas quando são acessadas pela primeira vez, otimizando o uso de memória.

---
