
# Automating Crypto Website API Pull

Automating Crypto Website API Pull is a project that demonstrates how to automate the process of fetching data from the CoinMarketCap API for cryptocurrency prices and details. This project provides a step-by-step approach to pulling data from the API, cleaning it, and creating visualizations for better insights.

Whether you're interested in tracking cryptocurrency prices, understanding market trends, or practising API automation, this project guides you through the entire process.


## Table of Contents

- [ Installation ](#install)
- [ Usage ](#usage)
- [ Data Processing ](#src)
- [ Visualization ](#viz)
- [ Contributing ](#contri)
- [ License ](#license)
- [ Authors ](#auth)


<a name="install"></a>
## Installation

To get started, make sure you have the following softwares installed:

1. Python (Pandas, Numpy, Matplotlib, Seaborn)
2. Microsoft Excel (or compatible spreadsheet software)


<a name="usage"></a>
## Usage

1. Import the necessary libraries in your Python script:

   ```bash
     from requests import Request, Session
     from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
     import json

     import pandas as pd
     import seaborn as sns
     import matplotlib.pyplot as plt

     import os
     from time import time
     from time import sleep
   ```

2. Write Python code to make API requests to the CoinMarketCap API and retrieve the cryptocurrency data. (https://coinmarketcap.com/api/)
3. Process the retrieved data using Pandas to clean and prepare it for analysis.
4. Create visualizations using Matplotlib to showcase the cryptocurrency price trends.


<a name="src"></a>
## Data Processing

Once the data is retrieved from the API, you can apply various data processing tasks using Python. This could include:

1. Cleaning the data
2. Transforming the data
3. Aggregating or summarizing data
4. Combining data from multiple sources

Customize the data processing steps based on your specific data requirements.


<a name="viz"></a>
## Visualization

1. Utilize Matplotlib to create various visualizations such as line charts, bar charts, or scatter plots.
2. Visualize cryptocurrency price trends, market capitalization, or trading volumes.
3. Customize the visualizations with appropriate labels, titles, and legends for better understanding.

![image](https://github.com/soham-parundekar/APIPull-Automation/assets/96282313/c51dbe69-85df-4565-9b53-6ba301754cc2) ![image](https://github.com/soham-parundekar/APIPull-Automation/assets/96282313/eafb9367-05ea-4f41-a875-6ed29b011892)


<a name="contri"></a>
## Contributing

We welcome contributions from the community to enhance Automating Crypto Website API Pull Using Python. If you'd like to contribute, please follow these steps:

1. Fork the repository and create a new branch for your feature or bug fix.
2. Make your changes and ensure that the code is properly documented.
3. Submit a pull request with a clear explanation of the changes and their benefits.
4. The project maintainers will review your contribution, provide feedback, and merge it once everything looks good.


<a name="license"></a>
## License

Automating Crypto Website API Pull is licensed under the MIT License. You can find the full license text in the [**LICENSE**](https://github.com/soham-parundekar/APIPull-Automation/blob/main/LICENSE) file.


## Authors

- [Soham Parundekar](https://www.github.com/soham-parundekar)
