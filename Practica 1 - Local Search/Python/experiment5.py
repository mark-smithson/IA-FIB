import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import argparse
import os

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

def executeHC(path, pen, outputFile):
    opts = " -pen " + str(pen)
    command = "java -jar -Xmx10000m " + "\"" + path + "\" -nc 1000 -nC 40 -h 1" + opts + " > " + outputFile
    print(command)
    os.system(command)

def executeSA(path, pen, outputFile):
    opts = " -pen " + str(pen)
    command = "java -jar -Xmx10000m " + "\"" + path + "\" -sa -nc 1000 -nC 40 -h 1" + opts + " > " + outputFile
    print(command)
    os.system(command)

def exp5HC(path):
    for pen in range(4300, 5000, 100):
        for i in range(10):
            outputFile = "outputsHC/" + str(pen) + "_" + str(i) + ".txt"
            executeHC(path, pen, outputFile)

def exp5SA(path):
    for pen in range(6000, 10000, 100):
        for i in range(10):
            outputFile = "outputsSA/" + str(pen) + "_" + str(i)  + ".txt"
            executeSA(path, pen, outputFile)

def get_time(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[-1]
    return float(line.split(': ')[1][:-8])

def get_clients(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[-5]
    return float(line.split(': ')[1])

def get_penalty(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[16]
    return float(line.split(': ')[1])

def get_maxClients(path):
    f = open(path, "r")
    list = f.readlines()
    line = list[-2]
    return(float(line.split(": ")[1].split(' ')[0]))

def getHeuristic(path):
    f = open(path, "r")
    list = f.readlines()
    line = list[-3]
    return(float(line.split(": ")[-1]))

def resHC_clients():
    penalties = []
    clients = []
    maxClients = []
    if os.path.exists("outputsHC"):
        flist = generate_files_list("outputsHC")
        for file in flist:
            penalties.append(get_penalty(file))
            clients.append(get_clients(file))
            maxClients.append(get_maxClients(file))


    df = pd.DataFrame({
        "penalties" : penalties,
        "clients" : clients,
        "maxClients": maxClients
    })

    df = df.sort_values('penalties')

    penalties = []
    clients = []
    maxClients = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        clients.append(df.loc[df['penalties'] == c].mean()[1])
        maxClients.append(df.loc[df['penalties'] == c].mean()[2])

    fig = go.Figure(layout_title_text="Gráfico clientes garantizados en función de la penalización con Hill Climbing")

    fig.add_trace(
        go.Scatter(
            x=penalties,
            y=maxClients,
            name="Clientes garantizados máximo"
        ))

    fig.add_trace(
        go.Bar(
            x=penalties,
            y=clients,
            name="Clientes garantizados conseguido"
        ))

    fig.write_image("plots/Ex5Im1.png")
    fig.show()

def resHC_times():
    penalties = []
    times = []
    if os.path.exists("outputsHC"):
        flist = generate_files_list("outputsHC")
        for file in flist:
            penalties.append(get_penalty(file))
            times.append(get_time(file))

    df = pd.DataFrame({
        "penalties" : penalties,
        "times" : times
    })

    df = df.sort_values('penalties')

    penalties = []
    times = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        times.append(df.loc[df['penalties'] == c].mean()[1])

    fig = px.line(
        x = penalties ,
        y = times,
        markers=True, title = 'Gráfico coste temporal en función de la penalización con Hill Climbing',
        labels = {"x": "Penalización", "y": "Tiempo de ejecución medio"})
    fig.show()
    fig.write_image("plots/tiempos_penaltiesHC.png")

def resHC_heur():
    penalties = []
    heur = []
    if os.path.exists("outputsHC"):
        flist = generate_files_list("outputsHC")
        for file in flist:
            penalties.append(get_penalty(file))
            heur.append(getHeuristic(file))

    df = pd.DataFrame({
        "penalties" : penalties,
        "heur" : heur
    })

    df = df.sort_values('penalties')

    penalties = []
    heur = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        heur.append(df.loc[df['penalties'] == c].mean()[1])

    fig = px.line(
        x = penalties,
        y = heur,
        markers=True, title = 'Gráfico heurística en función de la penalización con Hill Climbing',
        labels = {"x": "Penalización", "y": "Heurística"})
    fig.show()
    fig.write_image("plots/Ex5Im5.png")

def resSA_clients():
    penalties = []
    clients = []
    maxClients = []
    if os.path.exists("outputsSA"):
        flist = generate_files_list("outputsSA")
        for file in flist:
            penalties.append(get_penalty(file))
            clients.append(get_clients(file))
            maxClients.append(get_maxClients(file))


    df = pd.DataFrame({
        "penalties" : penalties,
        "clients" : clients,
        "maxClients": maxClients
    })

    df = df.sort_values('penalties')

    penalties = []
    clients = []
    maxClients = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        clients.append(df.loc[df['penalties'] == c].mean()[1])
        maxClients.append(df.loc[df['penalties'] == c].mean()[2])

    fig = go.Figure(layout_title_text="Gráfico clientes garantizados en función de la penalización con Simulated Annealing")

    fig.add_trace(
        go.Scatter(
            x=penalties,
            y=maxClients,
            name="Clientes garantizados máximo"
        ))

    fig.add_trace(
        go.Bar(
            x=penalties,
            y=clients,
            name="Clientes garantizados conseguido"
        ))

    fig.write_image("plots/Ex5Im2.png")
    fig.show()

def resSA_times():
    penalties = []
    times = []
    if os.path.exists("outputsSA"):
        flist = generate_files_list("outputsSA")
        for file in flist:
            penalties.append(get_penalty(file))
            times.append(get_time(file))

    df = pd.DataFrame({
        "penalties" : penalties,
        "times" : times
    })

    df = df.sort_values('penalties')

    penalties = []
    times = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        times.append(df.loc[df['penalties'] == c].mean()[1])

    fig = px.line(
        x = penalties ,
        y = times,
        markers=True, title = 'Gráfico coste temporal en función de la penalización con Simulated Annealing',
        labels = {"x": "Penalización", "y": "Tiempo de ejecución medio"})
    fig.show()
    fig.write_image("plots/tiempos_penaltiesSA.png")


def resSA_heur():
    penalties = []
    heur = []
    if os.path.exists("outputsSA"):
        flist = generate_files_list("outputsSA")
        for file in flist:
            penalties.append(get_penalty(file))
            heur.append(getHeuristic(file))

    df = pd.DataFrame({
        "penalties" : penalties,
        "heur" : heur
    })

    df = df.sort_values('penalties')

    penalties = []
    heur = []
    for c in df['penalties'].unique():
        penalties.append(df.loc[df['penalties'] == c].mean()[0])
        heur.append(df.loc[df['penalties'] == c].mean()[1])

    fig = px.line(
        x = penalties,
        y = heur,
        markers=True, title = 'Gráfico heurística en función de la penalización con Simulated Annealing',
        labels = {"x": "Penalización", "y": "Heurística"})
    fig.show()
    fig.write_image("plots/Ex5Im6.png")

def create_folder(folder_name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, folder_name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='Path of .jar file')
    args = parser.parse_args()

    create_folder(r"outputsHC")
    exp5HC(args.path)

    create_folder(r"outputsSA")
    exp5SA(args.path)

    create_folder(r"plots")
    resHC_clients()
    resHC_times()
    resHC_heur()
    resSA_clients()
    resSA_times()
    resSA_heur()