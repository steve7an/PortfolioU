# PortfolioU
An automatic trading system implementing the fuzzy logic, genetic algorithm trading system as written in this paper “Quantified moving average strategy of crude oil futures market based on fuzzy logic rules and genetic algorithms” by Xiaojia Liu, Haizhong An, Lijun Wang and Qing Guan

## Prerequisites
* Git
* Anaconda 1.9.2
* Jupyter Notebook 5.5.0
* Spyder 4.0
* Python 3.6

## Libraries
* matplotlib
* datetime  
* backtrader
* scikit-fuzzy
* ta-lib
* pandas
* numpy
* pytz

## Setup
Copy Scripts/skfuzzy/controlsystem.py to <Anaconda Installation Folder>\Lib\site-packages\skfuzzy\control. This is required to use the get antecedent function custom implementation.

## Running the solution
Please run the following commands on a terminal.
* git clone https://github.com/steve7an/PortfolioU.git
* cd PortfolioU/Scripts
* jupyter notebook
* Open bt2.ipynb on notebook
* run all the cells in order
