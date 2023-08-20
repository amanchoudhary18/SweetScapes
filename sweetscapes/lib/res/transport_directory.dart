class TransportDirectory {
  String getTransportIcon(String query) {
    String transportIcon = '';
    if (query == 'bus')
      transportIcon = 'assets/transportIcons/icons=Bus.svg';
    else if (query == 'auto')
      transportIcon = 'assets/transportIcons/icons=Bus.svg';
    else if (query == 'scooty')
      transportIcon = 'assets/transportIcons/icons=Bus.svg';
      else if (query == 'bike')
      transportIcon = 'assets/transportIcons/icons=Bike.svg';
      else if (query == 'mid_size')
      transportIcon = 'assets/transportIcons/icons=Bus.svg';
      else if (query == 'suv')
      transportIcon = 'assets/transportIcons/icons=Bus.svg';
      else if (query == 'walking')
      transportIcon = 'assets/transportIcons/icons=Walk.svg';
      else
      transportIcon = '';

    return transportIcon;
  }

  String getTransportLabel(String query) {
    String transportLabel = '';
    if (query == 'bus')
      transportLabel = 'Bus';
    else if (query == 'auto')
      transportLabel = 'Auto';
    else if (query == 'scooty')
      transportLabel = 'Scooty';
      else if (query == 'bike')
      transportLabel = 'Bike';
      else if (query == 'mid_size')
      transportLabel = 'Mid-Size Car';
      else if (query == 'suv')
      transportLabel = 'SUV';
      else if (query == 'walking')
      transportLabel = 'Walk';
      else
      transportLabel = '';

    return transportLabel;
  }

  
}
