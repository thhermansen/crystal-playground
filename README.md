# Playground

This is a repository where I play with https://crystal-lang.org/

## Develop

On MacOS I had to export env var:

```bash
echo $PKG_CONFIG_PATH
/usr/local/opt/openssl/lib/pkgconfig
```

You can build and boot app by:

```crystal src/playground.cr -- -p HttpServer```

## Build

`crystal build --release -o bin/playground src/playground.cr`

## Contributing

1. Fork it ( https://github.com/thhermansen/playground/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [thhermansen](https://github.com/thhermansen) Thorbjørn Hermansen - creator, maintainer
