// This file contains your Data Connector logic
section PQExtension2;

[DataSource.Kind="PQExtension2", Publish="PQExtension2.Publish"]
shared PQExtension2.Contents = (optional message as text) =>
    let
        _message = if (message <> null) then message else "(no message)",
        a = "Hello from PQExtension2: " & _message
    in
        a;

// Data Source Kind description
PQExtension2 = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Implicit = []
    ],
    Label = Extension.LoadString("DataSourceLabel")
];

// Data Source UI publishing description
PQExtension2.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = PQExtension2.Icons,
    SourceTypeImage = PQExtension2.Icons
];

PQExtension2.Icons = [
    Icon16 = { Extension.Contents("PQExtension216.png"), Extension.Contents("PQExtension220.png"), Extension.Contents("PQExtension224.png"), Extension.Contents("PQExtension232.png") },
    Icon32 = { Extension.Contents("PQExtension232.png"), Extension.Contents("PQExtension240.png"), Extension.Contents("PQExtension248.png"), Extension.Contents("PQExtension264.png") }
];