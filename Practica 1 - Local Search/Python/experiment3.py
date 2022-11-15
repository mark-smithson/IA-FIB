import plotly.express as px
import pandas as pd
import argparse
import os

def execute(path, stiter, k, lamb, outputFile):
    optStiter = " -S " + str(stiter)
    optK = " -k " + str(k)
    optLamb = " -l " + str(lamb)
    opts = "-sa -i 4 -nc 1000 -nC 40 -s 10000" + optStiter + optK + optLamb
    command = "java -jar -Xmx1000m " + "\"" + path + "\" " + opts + " > " + outputFile
    print(command)
    os.system(command)

def execute_experiment(path):
    ks = [5**x for x in range(6)]
    lambdas = list(map(lambda x: 1.0 / (10 ** x), range(10)))
    stiters = [x*10 for x in range(1, 10)]
    for i in range(10):
        for stiter in stiters:
            for k in ks:
                for lamb in lambdas:
                    outputFile = "outputs/1_" + str(stiter) + "_" + str(k) + "_" + str(lamb) + "-" + str(i)
                    execute(path, stiter, k, lamb, outputFile)

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

def get_new_benefit(path):
    file = open(path, 'r')
    lines = file.readlines()
    line = lines[-2]
    return float(line.split(": ")[3])

def plot_results():
    flist = generate_files_list("outputs")
    flist = sorted(flist)
    dictRes = {}
    lst = []
    title = None
    for file in flist:
        newTitle = file.split('/')[-1].split('-')
        if len(newTitle) == 3:
            newTitle = newTitle[0] + '-' + newTitle[1]
        else:
            newTitle = newTitle[0]
        benefit = get_new_benefit(file)
        if title != None and title != newTitle:
            dictRes[title] = lst
            lst = []

        lst.append(benefit)
        title = newTitle
    dictRes[title] = lst

    df = pd.DataFrame.from_dict(dictRes)
    # print(df.mean())
    idMax = 0
    idMin = 0
    means = df.mean()
    for i in range(len(means)):
        if means[i] > means[idMax]:
            idMax = i
        if means[i] < means[idMin]:
            idMin = i

    fig = px.line(df.iloc[:, [idMin, idMax]])
    fig.show()
    fig = px.line(df)
    fig.show()
    
        
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
    plot_results()