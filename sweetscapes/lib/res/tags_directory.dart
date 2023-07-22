class TagsDirectory {
  String getTagIcon(String query) {
    String tagIcon = '';
    if (query == 'Fine_Dining')
      tagIcon = 'assets/tagIcons/icons=fineDining.svg';
    else if (query == 'Decent_Dining')
      tagIcon = 'assets/tagIcons/icons=decentDining.svg';
    else if (query == 'Dhaba')
      tagIcon = 'assets/tagIcons/icons=dhabas.svg';
    else if (query == 'Cafe')
      tagIcon = 'assets/tagIcons/icons=cafes.svg';
    else if (query == 'Streetfood')
      tagIcon = 'assets/tagIcons/icons=streetfood.svg';
    else if (query == 'Hills')
      tagIcon = 'assets/tagIcons/icons=hills.svg';
    else if (query == 'Lakes')
      tagIcon = 'assets/tagIcons/icons=Lakes.svg';
    else if (query == 'Dams_Waterfalls')
      tagIcon = 'assets/tagIcons/icons=Dams_Waterfall.svg';
    else if (query == 'Malls')
      tagIcon = 'assets/tagIcons/icons=malls.svg';
    else if (query == 'Movie_Halls')
      tagIcon = 'assets/tagIcons/icons=movie.svg';
    else if (query == 'Parks')
      tagIcon = 'assets/tagIcons/icons=park.svg';
    else if (query == 'Clubbing')
      tagIcon = 'assets/tagIcons/icons=clubs.svg';
    else if (query == 'Night_Out')
      tagIcon = 'assets/tagIcons/icons=Night out.svg';
    else if (query == 'Shopping')
      tagIcon = 'assets/tagIcons/icons=shopping.svg';
    else if (query == 'Places_Of_Worship')
      tagIcon = 'assets/tagIcons/icons=religious.svg';
    else if (query == 'Museum')
      tagIcon = 'assets/tagIcons/icons=Museum.svg';
    else
      tagIcon = '';

    return tagIcon;
  }



  String getTagLabel(String query) {
    String tagLabel = '';
    if (query == 'Fine_Dining')
      tagLabel = 'Fine Dining';
    else if (query == 'Decent_Dining')
      tagLabel = 'Decent Dining';
    else if (query == 'Dhaba')
      tagLabel = 'Dhaba';
    else if (query == 'Cafe')
      tagLabel = 'Cafe';
    else if (query == 'Streetfood')
      tagLabel = 'Street Food';
    else if (query == 'Hills')
      tagLabel = 'Hills';
    else if (query == 'Lakes')
      tagLabel = 'Lakes';
    else if (query == 'Dams_Waterfalls')
      tagLabel = 'Dams, Waterfalls';
    else if (query == 'Malls')
      tagLabel = 'Malls';
    else if (query == 'Movie_Halls')
      tagLabel = 'Movie';
    else if (query == 'Parks')
      tagLabel = 'Parks';
    else if (query == 'Clubbing')
      tagLabel = 'Clubbing';
    else if (query == 'Night_Out')
      tagLabel = 'Night Out';
    else if (query == 'Shopping')
      tagLabel = 'Shopping';
    else if (query == 'Places_Of_Worship')
      tagLabel = 'Places of Worship';
    else if (query == 'Museum')
      tagLabel = 'Museum';
    else
      tagLabel = '';

    return tagLabel;
  }
}
