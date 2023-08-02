class TagsDirectory {
  String getTagIcon(String query) {
    String tagIcon = '';
    if (query == 'Fine_Dining' || query == 'Fine Dining' )
      tagIcon = 'assets/tagIcons/icons=fineDining.svg';
    else if (query == 'Decent_Dining' || query == 'Decent Dining')
      tagIcon = 'assets/tagIcons/icons=decentDining.svg';
    else if (query == 'Dhaba' || query == 'Dhabas')
      tagIcon = 'assets/tagIcons/icons=dhabas.svg';
    else if (query == 'Cafe' || query == 'Cafes')
      tagIcon = 'assets/tagIcons/icons=cafes.svg';
    else if (query == 'Streetfood' || query == 'Street Food')
      tagIcon = 'assets/tagIcons/icons=streetfood.svg';
    else if (query == 'Hills' || query == 'Hill')
      tagIcon = 'assets/tagIcons/icons=hills.svg';
    else if (query == 'Lakes' || query == 'Lake')
      tagIcon = 'assets/tagIcons/icons=Lakes.svg';
    else if (query == 'Dams_Waterfalls' || query == 'Dams Waterfalls')
      tagIcon = 'assets/tagIcons/icons=Dams_Waterfall.svg';
    else if (query == 'Malls' || query == 'Mall')
      tagIcon = 'assets/tagIcons/icons=malls.svg';
    else if (query == 'Movie_Halls' || query == 'Movie')
      tagIcon = 'assets/tagIcons/icons=movie.svg';
    else if (query == 'Parks' || query == 'Park')
      tagIcon = 'assets/tagIcons/icons=park.svg';
    else if (query == 'Clubbing' || query == 'Clubbing')
      tagIcon = 'assets/tagIcons/icons=clubs.svg';
    else if (query == 'Night_Out' || query == 'Night Out')
      tagIcon = 'assets/tagIcons/icons=Night out.svg';
    else if (query == 'Shopping')
      tagIcon = 'assets/tagIcons/icons=shopping.svg';
    else if (query == 'Places_Of_Worship' || query == 'Places Of Worship')
      tagIcon = 'assets/tagIcons/icons=religious.svg';
    else if (query == 'Museum')
      tagIcon = 'assets/tagIcons/icons=Museum.svg';
    else
      tagIcon = '';

    return tagIcon;
  }

  String getTagLabel(String query) {
    String tagLabel = '';
    if (query == 'Fine_Dining' || query == 'Fine Dining' )
      tagLabel = 'Fine Dining';
    else if (query == 'Decent_Dining' || query == 'Decent Dining')
      tagLabel = 'Decent Dining';
    else if (query == 'Dhaba' || query == 'Dhabas')
      tagLabel = 'Dhaba';
    else if (query == 'Cafe' || query == 'Cafes')
      tagLabel = 'Cafe';
    else if (query == 'Streetfood' || query == 'Street Food')
      tagLabel = 'Street Food';
    else if (query == 'Hills' || query == 'Hill')
      tagLabel = 'Hills';
    else if (query == 'Lakes' || query == 'Lake')
      tagLabel = 'Lakes';
    else if (query == 'Dams_Waterfalls' || query == 'Dams Waterfalls')
      tagLabel = 'Dams Waterfalls';
    else if (query == 'Malls' || query == 'Mall')
      tagLabel = 'Malls';
    else if (query == 'Movie_Halls' || query == 'Movie')
      tagLabel = 'Movie';
    else if (query == 'Parks' || query == 'Park')
      tagLabel = 'Parks';
    else if (query == 'Clubbing' || query == 'Clubbing')
      tagLabel = 'Clubbing';
    else if (query == 'Night_Out' || query == 'Night Out')
      tagLabel = 'Night Out';
    else if (query == 'Shopping')
      tagLabel = 'Shopping';
    else if (query == 'Places_Of_Worship' || query == 'Places Of Worship')
      tagLabel = 'Places of Worship';
    else if (query == 'Museum')
      tagLabel = 'Museum';
    else
      tagLabel = 'Unknown Tag';
    
    return tagLabel;
  }
}
