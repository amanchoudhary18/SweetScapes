class TagsDirectory {
  String getTagIcon(String query) {
    String tagIcon = '';
    if (query == 'Fine_Dining' || query == 'Fine Dining' )
      tagIcon = 'assets/tagIcons/icons=fineDining.svg';
    else if (query == 'Classic_Dine_In' || query == 'Classic Dine-In')
      tagIcon = 'assets/tagIcons/icons=classicDineIn.svg';
    else if (query == 'Restro-Bar' || query == 'RestroBar')
      tagIcon = 'assets/tagIcons/icons=RestroBar.svg';
    else if (query == 'Food-Court' || query == 'FoodCourt')
      tagIcon = 'assets/tagIcons/icons=FoodCourt.svg';
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
    else if (query == 'Dams_Waterfalls' || query == 'Dams & Waterfalls')
      tagIcon = 'assets/tagIcons/icons=Dams_Waterfall.svg';
    else if (query == 'Arcade' || query == 'Arcade')
      tagIcon = 'assets/tagIcons/icons=Arcade.svg';
    else if (query == 'Movie_Halls' || query == 'Movie')
      tagIcon = 'assets/tagIcons/icons=movie.svg';
    else if (query == 'Parks' || query == 'Park')
      tagIcon = 'assets/tagIcons/icons=park.svg';
    else if (query == 'Clubs_Bars' || query == 'Clubs & Bars')
      tagIcon = 'assets/tagIcons/icons=clubsBars.svg';
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
    else if (query == 'Classic_Dine_In' || query == 'Classic Dine-In')
      tagLabel = 'Classic Dine-In';
    else if (query == 'Restro-Bar' || query == 'RestroBar')
      tagLabel = 'Restro-Bar';
    else if (query == 'Food-Court' || query == 'FoodCourt')
      tagLabel = 'Food-Court';
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
    else if (query == 'Dams_Waterfalls' || query == 'Dams & Waterfalls')
      tagLabel = 'Dams & Waterfalls';
    else if (query == 'Arcade' || query == 'Arcade')
      tagLabel = 'Arcade';
    else if (query == 'Movie_Halls' || query == 'Movie')
      tagLabel = 'Movie';
    else if (query == 'Parks' || query == 'Park')
      tagLabel = 'Parks';
    else if (query == 'Clubs_Bars' || query == 'Clubs & Bars')
      tagLabel = 'Clubs & Bars';
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

  String getTagLabelForDatabase(String query) {
    String tagLabel = '';
    if (query == 'Fine Dining')
      tagLabel = 'Fine_Dining';
    else if (query == 'Classic Dine-In')
      tagLabel = 'Classic_Dine_In';
    else if (query == 'Restro-Bar')
      tagLabel = 'RestroBar';
    else if (query == 'Food-Court')
      tagLabel = 'FoodCourt';
    else if (query == 'Dhaba' || query == 'Dhabas')
      tagLabel = 'Dhabas';
    else if (query == 'Cafe' || query == 'Cafes')
      tagLabel = 'Cafes';
    else if (query == 'Street Food')
      tagLabel = 'Streetfood';
    else if (query == 'Hills')
      tagLabel = 'Hills';
    else if (query == 'Lakes')
      tagLabel = 'Lakes';
    else if (query == 'Dams & Waterfalls')
      tagLabel = 'Dams_Waterfalls';
    else if (query == 'Arcade')
      tagLabel = 'Arcade';
    else if (query == 'Movie')
      tagLabel = 'Movie_Halls';
    else if (query == 'Parks')
      tagLabel = 'Parks';
    else if (query == 'Clubs & Bars')
      tagLabel = 'Clubs_Bars';
    else if (query == 'Night Out')
      tagLabel = 'Night_Out';
    else if (query == 'Shopping')
      tagLabel = 'Shopping';
    else if (query == 'Places Of Worship')
      tagLabel = 'Places_Of_Worship';
    else if (query == 'Museum')
      tagLabel = 'Museum';
    else
      tagLabel = 'Unknown Tag';
    
    return tagLabel;
  }
}
