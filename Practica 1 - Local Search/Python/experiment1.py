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

def get_ops(lineNum):
    ops = []
    iniSol = 0
    if os.path.exists("outputs"):
        flist = generate_files_list("outputs")
        flist = sorted(flist)
        dataAux = []
        for file in flist:
            f = open(file, "r")
            list = f.readlines()
            line = list[lineNum]
            op = float(line.split(": ")[1])
            sol = float(list[1].split(':')[1])
            if sol == iniSol:
                dataAux.append(op)
            else:
                ops.append(sum(dataAux)/len(dataAux))
                dataAux = [op]
            iniSol = sol
        ops.append(sum(dataAux)/len(dataAux))
    return ops

def plot_data():
    adds = get_ops(-8)
    print(len(adds))
    print(adds)
    erases = get_ops(-7)
    moves = get_ops(-6)
    swaps = get_ops(-5)

    langs = ['Orden de llegada', 'Uniforme garantizados', 
            'Uniforme todos', 'Ordenados por consumo', 
            'Garantizados por distancia']

    fig = go.Figure()
    fig.add_trace(go.Bar(
        x=langs,
        y=adds,
        name='Add',
        marker_color='indianred'
    ))

    fig.add_trace(go.Bar(
        x=langs,
        y=erases,
        name='Remove',
        marker_color='lightsalmon'
    ))

    fig.add_trace(go.Bar(
        x=langs,
        y=moves,
        name='Move',
        marker_color='lightslategray'
    ))

    fig.add_trace(go.Bar(
        x=langs,
        y=swaps,
        name='Swap',
        marker_color='rgb(69,117,180)'
    ))

    # Here we modify the tickangle of the xaxis, resulting in rotated labels.
    fig.update_layout(barmode='group', xaxis_tickangle=-45, title_text="Acciones")
    fig.show()
    fig.write_image("plots/expansions.png")

def execute(path, iniSol, numClients, numCentrals, outputFile):
    optIniSol = " -i " + str(iniSol) + " "
    optNumClients = " -nc " + str(numClients) + " "
    optNumCentrals = " -nC " + str(numCentrals) + " "
    opts = optIniSol + optNumClients + optNumCentrals
    command = "java -jar -Xmx10000m " + "\"" + path + "\" " + opts + "> " + outputFile
    print(command)
    os.system(command)

def execute_experiment(path):
    iniSols = [x for x in range(5)]
    for i in range(len(iniSols)):
        for n in range(10):
            outputFile = "outputs/0_" + str(iniSols[i]) + "_" + str(n) + ".txt"
            execute(path, iniSols[i], 1000, 40, outputFile)

def create_folder(folder_name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, folder_name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='Path of .jar file')
    args = parser.parse_args()

    create_folder(r"outputs")
    execute_experiment(args.path)

    create_folder(r"plots")
    plot_data()