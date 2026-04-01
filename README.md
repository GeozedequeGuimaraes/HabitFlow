<div align="center">

# HabitFlow

App iOS de rastreamento de hábitos diários com persistência local, notificações e widget — SwiftUI · SwiftData · Charts · WidgetKit

[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=SwiftUI&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![SwiftData](https://img.shields.io/badge/SwiftData-5E5CE6?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/swiftdata)
[![Charts](https://img.shields.io/badge/Charts-34C759?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/charts)
[![WidgetKit](https://img.shields.io/badge/WidgetKit-FF9500?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/widgetkit)
[![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)

</div>

---

## Demo

<div align="center">
<img src="Screenshots/demo.gif" width="300" alt="Demo do app">
</div>div>

---

## Sobre o projeto

HabitFlow é um app iOS de rastreamento de hábitos que roda 100% offline. O usuário cria hábitos com nome, emoji, cor e dias da semana, marca conclusões diárias com animações e haptic feedback, acompanha estatísticas mensais com gráficos nativos do Charts e recebe lembretes via notificações locais. Um widget para a homescreen exibe o progresso do dia em tempo real.

---

## Funcionalidades

- Hábitos personalizados com nome, emoji, cor e dias da semana
- - Conclusão diária com animação e haptic feedback
  - - Progress ring com progresso semanal de cada hábito
    - - Streak tracking com contagem de dias consecutivos
      - - Estatísticas mensais com gráfico de barras por dia e barra de progresso por hábito
        - - Navegação entre meses para visualizar o histórico
          - - Notificações locais configuráveis por horário e dia da semana
            - - Widget na homescreen nos tamanhos Small e Medium
              - - Swipe para excluir e context menu para editar ou excluir via toque longo
                - - Persistência local com SwiftData, sem dependência de internet
                 
                  - ---

                  ## Tecnologias

                  - Swift 6 com strict concurrency
                  - - SwiftUI para interface declarativa e reativa
                    - - SwiftData para persistência local com `@Model` e `@Query`
                      - - Charts para gráficos nativos de barras
                        - - WidgetKit com TimelineProvider
                          - - UserNotifications com UNCalendarNotificationTrigger
                            - - MVVM com ViewModels usando `@Observable`
                             
                              - ---

                              ## Estrutura do projeto

                              ```
                              HabitFlow/
                              ├── HabitFlowApp.swift
                              ├── Models/
                              │   ├── Habit.swift
                              │   └── HabitEntry.swift
                              ├── ViewModels/
                              │   ├── HabitListViewModel.swift
                              │   ├── HabitFormViewModel.swift
                              │   └── StatsViewModel.swift
                              ├── Views/
                              │   ├── Home/
                              │   │   ├── HomeView.swift
                              │   │   ├── HabitRowView.swift
                              │   │   └── ProgressRingView.swift
                              │   ├── Form/
                              │   │   ├── HabitFormView.swift
                              │   │   ├── EmojiPickerView.swift
                              │   │   ├── ColorPickerView.swift
                              │   │   ├── WeekdayPickerView.swift
                              │   │   └── ReminderPickerView.swift
                              │   ├── Stats/
                              │   │   ├── StatsView.swift
                              │   │   ├── MonthSelectorView.swift
                              │   │   ├── StreakBarChartView.swift
                              │   │   └── HabitStatsRowView.swift
                              │   └── Shared/
                              │       ├── EmptyStateView.swift
                              │       └── DeleteConfirmView.swift
                              ├── Services/
                              │   ├── NotificationService.swift
                              │   └── WidgetDataService.swift
                              └── Utils/
                                  ├── ColorExtension.swift
                                  ├── DateExtension.swift
                                  └── Constants.swift
                              HabitFlowWidget/
                              ├── HabitFlowWidget.swift
                              ├── WidgetBundle.swift
                              ├── WidgetProvider.swift
                              └── WidgetEntryView.swift
                              ```

                              ---

                              ## Como executar

                              1. Clone o repositório
                             
                              2. ```bash
                                 git clone https://github.com/GeozedequeGuimaraes/HabitFlow.git
                                 ```

                                 2. Abra `HabitFlow.xcodeproj` no Xcode
                                 3. 3. Selecione um simulador ou dispositivo físico
                                    4. 4. Execute com `Cmd + R`
                                      
                                       5. > Para o widget funcionar com dados compartilhados, configure o App Group `group.br.geozedeque.habitflow` nos targets HabitFlow e HabitFlowWidgetExtension em Signing & Capabilities.
                                          >
                                          > ---
                                          >
                                          > ## Screenshots
                                          >
                                          > <div align="center">

                                          | Home | Home vazia | Formulário | Estatísticas |
                                          |------|-----------|-----------|-------------|
                                          | <img src="Screenshots/home.png" width="200"> | <img src="Screenshots/home_empty.png" width="200"> | <img src="Screenshots/form.png" width="200"> | <img src="Screenshots/stats.png" width="200"> |

                                          </div>

                                          ---

                                          ## Autor

                                          <div align="center">

                                          Geozedeque Guimarães — Estudante de Ciência da Computação, CIn-UFPE

                                          [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/GeozedequeGuimaraes)
                                          [![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/geozedeque-guimaraes/)

                                          </div>
