# MaterialIcons

Simple Swift package for [Material Icons][material-icons]. We currently support only macOS 12 or higher. 
Include it via SwiftPM and use as follows

```swift
import MaterialIcons

let bookIcon = Icon.book.asImage(
  dimension: 320,
  padding: 12,
  style: .filled,
  color: .black,
  backgroundColor: .white
)
```

Please note that due to bundled font resources, you need at least SwiftPM 5.3.
The bundled fonts in the package were downloaded from [fonts.googleapis.com][font-download-link].

The font loading code is a slightly modified version of [thii/Fontawesome.swift][thii-fontawesome].

## Generate `Icon`s from `ijmap`

Execute the generate script as follows

```
$ ./bin/generate_icons.py \
    --input-file ./Sources/MaterialIcons/MaterialIcons-Regular.ijmap
    --output-file ./Sources/MaterialIcons/Icon.generated.swift
```

[material-icons]: https://material.io/resources/icons
[font-download-link]: https://fonts.googleapis.com/css?family=Material+Icons|Material+Icons+Outlined|Material+Icons+Two+Tone|Material+Icons+Round|Material+Icons+Sharp
[thii-fontawesome]: https://github.com/thii/FontAwesome.swift
