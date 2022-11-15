import plotly.graph_objects as go
import plotly.express as px
import pandas as pd
import argparse
import os

def create_folder(folder_name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, folder_name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)

def generate_files_list(path):
    if path[-1] == '/':
        path = path[:-1]

    lfiles = []

    for lf in os.walk(path):
        if lf[2]:
            for f in lf[2]:
                if f[0] != '.':
                    lfiles.append(lf[0] + '/' + f)
    return lfiles

def get_time(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[-1]
    return float(line.split(': ')[1][:-8])

def get_clients(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[3]
    return float(line.split(': ')[1])

def get_centrals(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[4]
    return float(line.split(': ')[1])

def get_heuristics(path):
    f = open(path, "r")
    list = f.readlines()
    line = list[-3]
    return float(line.split(": ")[1].split(',')[0])

def execute(path, nClients, nCentrals, outputFile):
    optnClients = " -nc " + str(nClients)
    optnCentrals = " -nC " + str(nCentrals)
    opts = optnClients + optnCentrals
    command = "java -jar -Xmx10000m " + "\"" + path + "\"" + opts + " > " + outputFile
    print(command)
    os.system(command)

def execute_experiment1(path):
    nCentrales = 40
    for nClients in range(500, 10000, 500):
        for i in range(10):
            outputFile = "outputs1/" + str(nClients) + "_" + str(nCentrales) + "_" + str(i) + ".txt"
            execute(path, nClients, nCentrales, outputFile)


def execute_experiment2(path):
    nClients = 1000
    for nCentrals in range(40, 400, 40):
        for i in range(10):
            outputFile = "outputs2/" + str(nClients) + "_" + str(nCentrals) + "_" + str(i) + ".txt"
            execute(path, nClients, nCentrals, outputFile)


def plot_results1():
    times = []
    clientes = []
    if os.path.exists("outputs1"):
        flist = generate_files_list("outputs1")
        for file in flist:
            times.append(get_time(file))
            clientes.append(get_clients(file))

    df = pd.DataFrame({
        "clientes" : clientes,
        "times" : times
    })
    
    df = df.sort_values('clientes')
    
    times = []
    clientes = []
    for c in df['clientes'].unique():
        times.append(df.loc[df['clientes'] == c].mean()[1])
        clientes.append(df.loc[df['clientes'] == c].mean()[0])

    fig = px.line( 
        x = clientes ,
        y = times,  
        markers=True, title = 'Gráfico coste temporal en función del número de clientes',
        labels = {"x": "Número de clientes", "y": "Tiempo de ejecución medio"})
    fig.show()
    fig.write_image("plots/tiempos_clientes.png")


def plot_results2():
    times = []
    centrals = []
    if os.path.exists("outputs2"):
        flist = generate_files_list("outputs2")
        flist = sorted(flist)
        for file in flist:
            times.append(get_time(file))
            centrals.append(get_centrals(file))

    df = pd.DataFrame({
        "centrales" : centrals,
        "times" : times
    })
    
    df = df.sort_values('centrales')
    
    times = []
    centrales = []
    for c in df['centrales'].unique():
        times.append(df.loc[df['centrales'] == c].mean()[1])
        centrales.append(df.loc[df['centrales'] ==c].mean()[0])

    fig = px.line( 
        x = centrales ,
        y = times,  
        markers=True, title = 'Gráfico coste temporal en función del número de centrales',
        labels = {"x": "Número de centrales", "y": "Tiempo de ejecución medio"})
    fig.show()
    fig.write_image("plots/tiempos_centrales.png")

def plot_heuristics1():
    heuristics = []
    clientes = []
    if os.path.exists("outputs1"):
        flist = generate_files_list("outputs1")
        for file in flist:
            heuristics.append(get_heuristics(file))
            clientes.append(get_clients(file))

    df = pd.DataFrame({
        "clientes" : clientes,
        "heuristics" : heuristics
    })
    
    df = df.sort_values('clientes')
    
    heuristics = []
    clientes = []
    for c in df['clientes'].unique():
        heuristics.append(df.loc[df['clientes'] == c].mean()[1])
        clientes.append(df.loc[df['clientes'] == c].mean()[0])

    fig = px.line( 
        x = clientes ,
        y = heuristics,  
        markers=True, 
        title = 'Gráfico del heurístico aumentando el número de cliente',
        labels = {"x": "Número de clientes", "y": "heurística media"})
    fig.show()
    fig.write_image("plots/heuristics_clientes.png")

def plot_heuristics2():
    heuristics = []
    centrales = []
    if os.path.exists("outputs2"):
        flist = generate_files_list("outputs2")
        for file in flist:
            heuristics.append(get_heuristics(file))
            centrales.append(get_centrals(file))

    df = pd.DataFrame({
        "centrales" : centrales,
        "heuristics" : heuristics
    })
    
    df = df.sort_values('centrales')
    
    heuristics = []
    centrales = []
    for c in df['centrales'].unique():
        heuristics.append(df.loc[df['centrales'] == c].mean()[1])
        centrales.append(df.loc[df['centrales'] == c].mean()[0])

    fig = px.line( 
        x = centrales,
        y = heuristics,  
        markers=True, 
        title = 'Gráfico del heurístico aumentando el número de centrales',
        labels = {"x": "Número de centrales", "y": "heurística media"})
    fig.show()
    fig.write_image("plots/heuristics_centrales.png")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='Path of .jar file')
    args = parser.parse_args()


    create_folder(r"outputs1")
    execute_experiment1(args.path)

    create_folder(r"outputs2")
    execute_experiment2(args.path)

    
    create_folder(r"plots")
    plot_results1()
    plot_results2()
    plot_heuristics1()
    plot_heuristics2()