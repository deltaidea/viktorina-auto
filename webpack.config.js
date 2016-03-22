module.exports = {
  entry: {
    "viktorina-auto": "./source/index-content.coffee",
    "inject": "./source/index-inject.coffee"
  },
  output: {
    path: "./extension",
    filename: "[name].js"
  },
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" }
    ]
  },
  resolve: {
    extensions: [ "", ".js", ".coffee" ]
  }
}
