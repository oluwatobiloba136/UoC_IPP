// This file contains your Data Connector logic
[Version = "1.0.0"]
section myConnector;

[DataSource.Kind="myConnector", Publish="myConnector.Publish"]
shared myConnector.Contents = (optional message as text) =>
    let
        _message = if (message <> null) then message else "(no message)",
        a = "Hello from myConnector: " & _message
    in
        a;

// Data Source Kind description
myConnector = [
    Authentication = [
        // Key = [],
        // UsernamePassword = [],
        // Windows = [],
        Anonymous = []
    ]
];

// Data Source UI publishing description
myConnector.Publish = [
    Beta = true,
    Category = "Other",
    ButtonText = { Extension.LoadString("ButtonTitle"), Extension.LoadString("ButtonHelp") },
    LearnMoreUrl = "https://powerbi.microsoft.com/",
    SourceImage = myConnector.Icons,
    SourceTypeImage = myConnector.Icons
];

myConnector.Icons = [
    Icon16 = { Extension.Contents("myConnector16.png"), Extension.Contents("myConnector20.png"), Extension.Contents("myConnector24.png"), Extension.Contents("myConnector32.png") },
    Icon32 = { Extension.Contents("myConnector32.png"), Extension.Contents("myConnector40.png"), Extension.Contents("myConnector48.png"), Extension.Contents("myConnector64.png") }
];




