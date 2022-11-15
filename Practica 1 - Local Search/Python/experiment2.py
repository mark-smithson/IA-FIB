import plotly.graph_objects as go
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

def plot_heuristics(path):
    data = []
    iniSol = 0
    if os.path.exists(path):
        flist = generate_files_list(path)
        flist = sorted(flist)
        dataAux = []
        for file in flist:
            f = open(file, "r")
            list = f.readlines()
            line = list[-3]
            cost = float(line.split(": ")[1].split(',')[0])
            sol = float(list[1].split(':')[1])
            if sol == iniSol:
                dataAux.append(cost)
            else:
                iniSol = sol
                data.append(dataAux)
                dataAux = [cost]
        data.append(dataAux)

    fig = go.Figure()
    fig.add_trace(go.Box(y=data[0], name="Orden de llegada"))
    fig.add_trace(go.Box(y=data[1], name="Uniforme garantizados"))
    fig.add_trace(go.Box(y=data[2], name="Uniforme todos"))
    fig.add_trace(go.Box(y=data[3], name="Ordenados por consumo"))
    fig.add_trace(go.Box(y=data[4], name="Garantizados por distancia"))
    fig.update_traces(boxpoints='all', jitter=0)
    fig.update_yaxes(visible=True, showticklabels=True)
    fig.update_layout(title_text="Heurístico")
    fig.show()
    fig.write_image("plots/heuristics.png")

def plot_times(path):
    data = []
    iniSol = 0
    if os.path.exists(path):
        flist = generate_files_list(path)
        flist = sorted(flist)
        dataAux = []
        for file in flist:
            f = open(file, "r")
            list = f.readlines()
            line = list[-1]
            time = float(line.split(": ")[1].split(' ')[0])
            sol = float(list[1].split(':')[1])
            if sol == iniSol:
                dataAux.append(time)
            else:
                iniSol = sol
                data.append(dataAux)
                dataAux = [time]
        data.append(dataAux)

    fig = go.Figure()
    fig.add_trace(go.Box(y=data[0], name="Orden de llegada"))
    fig.add_trace(go.Box(y=data[1], name="Uniforme garantizados"))
    fig.add_trace(go.Box(y=data[2], name="Uniforme todos"))
    fig.add_trace(go.Box(y=data[3], name="Ordenados por consumo"))
    fig.add_trace(go.Box(y=data[4], name="Garantizados por distancia"))
    fig.update_traces(boxpoints='all', jitter=0)
    fig.update_yaxes(visible=True, showticklabels=True)
    fig.update_layout(title_text="Tiempos")
    fig.show()
    fig.write_image("plots/times.png")

def plot_nodes_expansion(path):
    data = []
    iniSol = 0
    if os.path.exists(path):
        flist = generate_files_list(path)
        flist = sorted(flist)
        dataAux = []
        for file in flist:
            f = open(file, "r")
            list = f.readlines()
            line = list[-4]
            expandedNodes = float(line.split(": ")[1])
            sol = float(list[1].split(':')[1])
            if sol == iniSol:
                dataAux.append(expandedNodes)
            else:
                iniSol = sol
                data.append(dataAux)
                dataAux = [expandedNodes]
        data.append(dataAux)

    fig = go.Figure()
    fig.add_trace(go.Box(y=data[0], name="Orden de llegada"))
    fig.add_trace(go.Box(y=data[1], name="Uniforme garantizados"))
    fig.add_trace(go.Box(y=data[2], name="Uniforme todos"))
    fig.add_trace(go.Box(y=data[3], name="Ordenados por consumo"))
    fig.add_trace(go.Box(y=data[4], name="Garantizados por distancia"))
    fig.update_traces(boxpoints='all', jitter=0)
    fig.update_yaxes(visible=True, showticklabels=True)
    fig.update_layout(title_text="Nodos expandidos")
    fig.show()
    fig.write_image("plots/nodes_expansion.png")

def create_folder(folder_name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, folder_name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='Path of the outputs of the first experiment file')
    args = parser.parse_args()

    if os.path.exists(args.path):
        create_folder(r"plots")
        plot_heuristics(args.path)
        plot_times(args.path)
        plot_nodes_expansion(args.path)
    