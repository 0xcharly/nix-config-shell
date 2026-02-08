import Quickshell.Io

JsonObject {
    id: root

    property Fonts.Family families: Fonts.Family {}
    property Fonts.Size sizes: Fonts.Size {}
    property Fonts.Weight weights: Fonts.Weight {}

    property Fonts.Style icon: Fonts.Style {
        family: root.families.icon
        size: root.sizes.large
        weight: root.weights.normal
        italic: false
        underline: false
    }
    property Fonts.Style smallLabel: Fonts.Style {
        family: root.families.sansSerif
        size: root.sizes.extraSmall
        weight: root.weights.medium
    }
    property Fonts.Style mediumLabel: Fonts.Style {
        family: root.families.sansSerif
        size: root.sizes.small
        weight: root.weights.medium
    }
    property Fonts.Style body: Fonts.Style {
        family: root.families.sansSerif
        size: root.sizes.medium
        weight: root.weights.normal
        italic: false
        underline: false
    }
    property Fonts.Style title: Fonts.Style {
        family: root.families.sansSerif
        size: root.sizes.large
        weight: root.weights.normal
        italic: false
        underline: false
    }
    property Fonts.Style display: Fonts.Style {
        family: root.families.sansSerif
        size: root.sizes.extraLarge
        weight: root.weights.normal
        italic: false
        underline: false
    }
}
