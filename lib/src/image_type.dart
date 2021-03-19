/// Tells the type of images from the images string list
enum ImageType {
  /// Images are url
  URL,

  /// Images are assets
  ASSET,

  /// Images are base64 encoded string
  BYTES,

  /// Images are files paths from system
  FILE
}
