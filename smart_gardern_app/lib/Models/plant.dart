class Plant {
  String name;
  String familyName;
  String height;
  String spread;
  String info;
  String imageURL;
  // Info format
  // height:100,weight:100,spread:365cm
  Plant(this.name, this.familyName, this.spread, this.height, this.info,
      this.imageURL);
}

class PlantModel {
  List<Plant> plants = [
    Plant(
        "Nectarine",
        "Prunus persica",
        "365",
        "1000",
        "The nectarine is a deciduous tree that produces stone, or drupe, fruits. It is actually the same species as a Peach, it just has a recessive gene that makes it's skin smooth rather than fuzzy. Both fruits belong to the genus Prunus which includes the cherry, apricot, almond, and plum. The peach and nectarine are classified with the almond in the subgenus Amygdalus because their stones are corrugated rather than smooth. Most cultivars require 500 hours of chilling at temperatures between 0 and 10 °C during the winter, and hot temperatures in the summer to ripen fruit. Some varieties are self-pollinating, while others require pollination by a peach or nectarine tree of another variety with the same bloom period within 50 feet. Standard and dwarf rootstocks are available. Dwarf trees can grow to 3 meters, standard to 4.5 meters. Depending on the size chosen, the tree will bear fruit within 2-4 years of planting.",
        ""),
    Plant(
        "Apricot",
        "Prunus armeniaca",
        "450",
        "450",
        "The apricot is a small fruiting tree in the genus Prunus (of which other stone fruits like peaches, plums and cherries are also members). It is a section of the Prunus (Plum) subgenus. The apricot tree has a dense, spreading canopy with white to pinkish flowers. It's fruit are yellow to orange, smaller than peaches, and have smooth or velvety skin. The apricot can tolerate winter temperatures down to −30 °C, making it slightly more cold-hardy than peach trees. However, it is susceptible to spring frosts killing the blooms because it tends to flower very early. Some varieties are self-pollinating, but all apricot trees benefit from a pollination partner with the same bloom time within 15 meters. Standard and dwarf rootstocks are available. Dwarf trees can grow to 3 meters, standard to 4.5 meters. Depending on the size chosen, the tree will bear fruit within 2-4 years of planting.",
        "smart_gardern_app/assets/demo_images/aparicot.jpg"),
    Plant(
        "Fennel",
        "Foeniculum vulgare",
        "60",
        "60",
        "Fennel is a flowering plant species with yellow flowers and feathery leaves. It is grown primarily for its bulbous white base and green leaf stalks, which have a mild, fresh licorice flavor. It's base and stalks are delicious roasted, grilled, or eaten fresh.",
        "")
  ];
}
