import mysql.connector
import pandas as pd # To make the output more readable
import warnings # To supress any warnings

warnings.filterwarnings('ignore') #Supressing the warning to enhance output readability. 
                                  #This does not affect the main objective of the project: to learn and execute sql queries

def query(q):
    """
    Execute a SQL query on a MySQL database and return the results as a Pandas DataFrame.

    Parameters:
        q (str): The SQL query to be executed.

    MySQL server credentials are provided in the 'db_config' dictionary.

    Returns:
        pd.DataFrame: A DataFrame containing the query results.
    """
    
    #MySQL server credentials
    db_config = {
        'host': 'localhost',
        'user': 'root',
        'password': 'sqlsequel',
        'database': 'sqlzoo'
    }
    
    # Connect to the MySQL server
    conn = mysql.connector.connect(**db_config)
    
    # Define and execute a raw SQL query
    df = pd.read_sql_query(q, conn)
    
    # Returning the Pandas DataFrame
    return df
    
    # Close the connection
    conn.close()
    
