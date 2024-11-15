class  RecipeModel{

  late String appLabel;
  late String appimageUrl;
  late double appcalories;
  late String appurl;

  RecipeModel({this.appLabel="LABEL",this.appimageUrl="IMAGE",this.appcalories=0.000,this.appurl="URL"});

  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
        appLabel:recipe["label"],
        appimageUrl:recipe["image"],
        appcalories:recipe["calories"],
        appurl:recipe["url"]
    );
  }
}