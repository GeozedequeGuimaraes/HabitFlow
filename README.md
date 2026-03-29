<div align="center">

# HabitFlow

### App iOS de rastreamento de habitos diarios com persistencia local, notificacoes personalizadas e widget na homescreen -- construido com SwiftUI, SwiftData, Charts e WidgetKit

[![Swift](https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/swift/)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-0D96F6?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/xcode/swiftui/)
[![SwiftData](https://img.shields.io/badge/SwiftData-5E5CE6?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/swiftdata)
[![Charts](https://img.shields.io/badge/Charts-34C759?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/charts)
[![WidgetKit](https://img.shields.io/badge/WidgetKit-FF9500?style=for-the-badge&logo=swift&logoColor=white)](https://developer.apple.com/documentation/widgetkit)
[![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)](https://developer.apple.com/xcode/)

</div>

---

## Sobre o Projeto

**HabitFlow** e um app completo de rastreamento de habitos que funciona 100% offline. O usuario cria habitos personalizados com emoji, cor e dias da semana, marca conclusoes diarias com animacoes e haptic feedback, acompanha estatisticas mensais com graficos nativos do framework Charts, e recebe lembretes via notificacoes locais. O app tambem inclui um widget para a homescreen que mostra o progresso do dia em tempo real.

---

## Screenshots

<div align="center">

| Home | Formulario | Estatisticas |
|:---:|:---:|:---:|
| <img src="Screenshots/home.png" width="250"> | <img src="Screenshots/form.png" width="250"> | <img src="Screenshots/stats.png" width="250"> |

</div>

---

## Funcionalidades

- **Criar habitos personalizados** -- nome, emoji, cor e dias da semana
- **Marcar conclusao diaria** -- com animacao e haptic feedback
- **Progress ring** -- anel circular mostrando o progresso semanal de cada habito
- **Streak tracking** -- contagem de dias consecutivos de conclusao
- **Estatisticas mensais** -- grafico de barras por dia e barra de progresso por habito
- **Navegacao entre meses** -- visualizar historico de qualquer mes
- **Notificacoes locais** -- lembretes configuraveis por horario e dia da semana
- **Widget na homescreen** -- tamanhos Small e Medium com dados em tempo real
- **Swipe para excluir** -- exclusao rapida com gesto de swipe
- **Context menu** -- editar ou excluir via toque longo
- **100% offline** -- persistencia local com SwiftData, sem dependencia de internet

---

## Tecnologias

- **Swift 6** -- linguagem principal com strict concurrency
- **SwiftUI** -- interface declarativa e reativa
- **SwiftData** -- persistencia local com @Model e @Query
- **Charts** -- graficos nativos de barras para estatisticas
- **WidgetKit** -- widget da homescreen com TimelineProvider
- **UserNotifications** -- notificacoes locais com UNCalendarNotificationTrigger
- **MVVM** -- arquitetura com ViewModels usando @Observable

---

## Estrutura do Projeto

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

## Como Executar

1. Clone o repositorio
   ```bash
   git clone https://github.com/GeozedequeGuimaraes/HabitFlow.git
   ```
2. Abra o arquivo `HabitFlow.xcodeproj` no Xcode
3. Selecione um simulador ou dispositivo fisico
4. Execute o projeto com `Cmd + R`

> **Nota:** Para o widget funcionar com dados compartilhados, configure o App Group `group.br.geozedeque.habitflow` nos targets HabitFlow e HabitFlowWidgetExtension em Signing & Capabilities.

---

## Autor

<div align="center">

**Geozedeque Guimaraes**

Estudante de Ciencia da Computacao -- CIn-UFPE

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=flat-square&logo=github&logoColor=white)](https://github.com/GeozedequeGuimaraes)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/geozedeque-guimaraes/)

</div>
