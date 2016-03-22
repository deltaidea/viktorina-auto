module.exports = {
  entry: "./source/index.coffee",
  output: {
    path: "./extension",
    filename: "viktorina-auto.js"
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
