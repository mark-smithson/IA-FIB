import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import argparse
import os

def execute(path, hill, centralesA, centralesB, centralesC, outputFile):
    optHill = ""
    if not hill:
        optHill = " -sa"
    optCentralesA = " -a " + str(centralesA)
    optCentralesB = " -b " + str(centralesB)
    optCentralesC = " -c " + str(centralesC)
    opts = optHill + optCentralesA + optCentralesB + optCentralesC
    command = "java -jar -Xmx10000m " + "\"" + path + "\"" + " -nc 1000 -nC 40" + opts + " > " + outputFile
    print(command)
    os.system(command)

def execute_experiment_hill(path):
    for i in range(10):
        execute(path, True, 0.125, 0.25, 0.625, "outputs/0_0_"+str(i)+".txt")
        execute(path, True, 0.125, 0.25, 0.625*2, "outputs/0_1_"+str(i)+".txt")
        execute(path, True, 0.125, 0.25, 0.625*3, "outputs/0_2_"+str(i)+".txt")

def execute_experiment_sa(path):
    for i in range(10):
        execute(path, False, 0.125, 0.25, 0.625, "outputs/1_0_"+str(i)+".txt")
        execute(path, False, 0.125, 0.25, 0.625*2, "outputs/1_1_"+str(i)+".txt")
        execute(path, False, 0.125, 0.25, 0.625*3, "outputs/1_2_"+str(i)+".txt")

def get_clientsC(path):
    file = open(path, "r")
    lines = file.readlines()
    ctrs = lines[lines.index('Centrales:\n')+1:lines.index('Clientes:\n')]
    centralesX = []
    centralesY = []
    centralesTipo = []
    for i in range(0, len(ctrs), 3):
        centralesX.append(float(ctrs[i]))
        centralesY.append(float(ctrs[i+1]))
        centralesTipo.append(float(ctrs[i+2]))
    
    cls = lines[lines.index('Clientes:\n')+1:]
    clientesX = []
    clientesY = []
    asignacion = []
    clients = 0
    clientsA = 0
    clientsB = 0
    for i in range(0, len(cls), 4):
        if not cls[i][0].isnumeric():
            break
        clientesX.append(float(cls[i]))
        clientesY.append(float(cls[i+1]))
        id = int(cls[i+3])
        asignacion.append(id)
        if centralesTipo[id] == 2.:
            clients += 1
        elif centralesTipo[id] == 0:
            clientsA += 1
        else:
            clientsB += 1

    return clients, clientsB, clientsA

def plot_results_hill():
    flist = generate_files_list("outputs", "0_0")
    clients0 = []
    clients0B = []
    clients0A = []
    for file in flist:
        clients0.append(get_clientsC(file)[0])
        clients0B.append(get_clientsC(file)[1])
        clients0A.append(get_clientsC(file)[2])

    flist = generate_files_list("outputs", "0_1")
    clients1 = []
    clients1B = []
    clients1A = []
    for file in flist:
        clients1.append(get_clientsC(file)[0])
        clients1B.append(get_clientsC(file)[1])
        clients1A.append(get_clientsC(file)[2])

    flist = generate_files_list("outputs", "0_2")
    clients2 = []
    clients2B = []
    clients2A = []

    for file in flist:
        clients2.append(get_clientsC(file)[0])
        clients2B.append(get_clientsC(file)[1])
        clients2A.append(get_clientsC(file)[2])

    total1 = avg(clients0A) + avg(clients0B) + avg(clients0)
    total2 = avg(clients1A) + avg(clients1B) + avg(clients1)
    total3 = avg(clients2A) + avg(clients2B) + avg(clients2)

    l = [["original", "Tipo A", avg(clients0A)/total1*100], ["original", "Tipo B", avg(clients0B)/total1*100], ["original", "Tipo C", avg(clients0)/total1*100],
        ["duplicando C", "Tipo A", avg(clients1A)/total2*100], ["duplicando C", "Tipo B", avg(clients1B)/total2*100], ["duplicando C", "Tipo C", avg(clients1)/total2*100],
        ["triplicando C", "Tipo A", avg(clients2A)/total3*100], ["triplicando C", "Tipo B", avg(clients2B)/total3*100], ["triplicando C", "Tipo C", avg(clients2)/total3*100]]

    df = pd.DataFrame(l, columns =['Factor multiplicador', 'Tipo', 'Porcentaje de cada tipo'])

    fig = px.bar(df, x="Factor multiplicador", y="Porcentaje de cada tipo", color="Tipo", title="Gráfico de aumento de centrales de tipo C con usando Hill Climbing")

    fig.show()
    fig.write_image("plots/clientes_hc.png")

def plot_results_sa():
    flist = generate_files_list("outputs", "1_0")
    clients0 = []
    clients0B = []
    clients0A = []
    for file in flist:
        clients0.append(get_clientsC(file)[0])
        clients0B.append(get_clientsC(file)[1])
        clients0A.append(get_clientsC(file)[2])

    flist = generate_files_list("outputs", "1_1")
    clients1 = []
    clients1B = []
    clients1A = []
    for file in flist:
        clients1.append(get_clientsC(file)[0])
        clients1B.append(get_clientsC(file)[1])
        clients1A.append(get_clientsC(file)[2])

    flist = generate_files_list("outputs", "1_2")
    clients2 = []
    clients2B = []
    clients2A = []

    for file in flist:
        clients2.append(get_clientsC(file)[0])
        clients2B.append(get_clientsC(file)[1])
        clients2A.append(get_clientsC(file)[2])

    total1 = avg(clients0A) + avg(clients0B) + avg(clients0)
    total2 = avg(clients1A) + avg(clients1B) + avg(clients1)
    total3 = avg(clients2A) + avg(clients2B) + avg(clients2)

    l = [["original", "Tipo A", avg(clients0A)/total1*100], ["original", "Tipo B", avg(clients0B)/total1*100], ["original", "Tipo C", avg(clients0)/total1*100],
        ["duplicando C", "Tipo A", avg(clients1A)/total2*100], ["duplicando C", "Tipo B", avg(clients1B)/total2*100], ["duplicando C", "Tipo C", avg(clients1)/total2*100],
        ["triplicando C", "Tipo A", avg(clients2A)/total3*100], ["triplicando C", "Tipo B", avg(clients2B)/total3*100], ["triplicando C", "Tipo C", avg(clients2)/total3*100]]

    df = pd.DataFrame(l, columns =['Factor multiplicador', 'Tipo', 'Porcentaje de cada tipo'])

    fig = px.bar(df, x="Factor multiplicador", y="Porcentaje de cada tipo", color="Tipo", title="Gráfico de aumento de centrales de tipo C usando Simulated Annealing")

    fig.show()
    fig.write_image("plots/clientes_sa.png")

def get_time(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[-1]
    return float(line.split(': ')[1][:-8])

def avg(lst):
    return sum(lst)/len(lst)

def plot_times_hill():
    flist = generate_files_list("outputs", "0_0")
    times0 = []
    for file in flist:
        times0.append(get_time(file))
        
    flist = generate_files_list("outputs", "0_1")
    times1 = []
    for file in flist:
        times1.append(get_time(file))

    flist = generate_files_list("outputs", "0_2")
    times2 = []
    for file in flist:
        times2.append(get_time(file))

    fig = px.line( x = [x for x in range(1, 4)] ,
              y = [avg(times0), avg(times1), avg(times2)],  
              markers=True, title = 'Gráfico coste temporal usando Hill Climbing',
              labels = {"x": "Factor de multiplicación de la proporción de centrales de tipo C", "y": "Tiempo"})
    fig.write_image("plots/tiempos_hc.png")
    fig.show()

def plot_times_sa():
    flist = generate_files_list("outputs", "1_0")
    times0 = []
    for file in flist:
        times0.append(get_time(file))
        
    flist = generate_files_list("outputs", "1_1")
    times1 = []
    for file in flist:
        times1.append(get_time(file))

    flist = generate_files_list("outputs", "1_2")
    times2 = []
    for file in flist:
        times2.append(get_time(file))

    fig = px.line( x = [x for x in range(1, 4)] ,
              y = [avg(times0), avg(times1), avg(times2)],  
              markers=True, title = 'Gráfico coste temporal usando Simulated Annealing',
              labels = {"x": "Factor de multiplicación de la proporción de centrales de tipo C", "y": "Tiempo"})
    fig.write_image("plots/tiempos_sa.png")
    fig.show()

def create_folder(folder_name):
    current_directory = os.getcwd()
    final_directory = os.path.join(current_directory, folder_name)
    if not os.path.exists(final_directory):
        os.makedirs(final_directory)

def generate_files_list(path, start):
    if path[-1] == '/':
        path = path[:-1]

    lfiles = []

    for lf in os.walk(path):
        if lf[2]:
            for f in lf[2]:
                if f[0] != '.':
                    lfiles.append(lf[0] + '/' + f)

    lfiles = [x for x in lfiles if x.startswith(path + "/" + start)]
    return lfiles

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('path', help='Path of .jar file')
    args = parser.parse_args()

    create_folder("outputs")
    execute_experiment_hill(args.path)
    execute_experiment_sa(args.path)

    create_folder("plots")
    plot_results_hill()
    plot_results_sa()
    plot_times_hill()
    plot_times_sa()