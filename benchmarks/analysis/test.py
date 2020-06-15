import networkx as nx
import matplotlib.pyplot as plt
import random
import sys
import math
import json
import os
import pickle
def gen_graph(n): # Generates random graph. Complete graph for n<100 and Erdős-Rényi Graph with p=ln(n)/n to make sure the graph has a order n connected component. 
    if (n<100):
        G=nx.complete_graph(n)
    else:
        G=nx.random_tree(n)
        #G = nx.gnp_random_graph(n,(math.log(n))/n)
    for u,v in G.edges():
        G.edges[u,v]['weight']=random.random()*(10**6)
    #nx.draw(G, with_labels=True, font_weight='bold')
    #plt.show()
    return G
def instant_write(s,file):
    file.write(s)
    file.flush()
if __name__=='__main__':
    times=[]
    memory=[]
    for i in range(int(sys.argv[1]),1+int(sys.argv[2]),int(sys.argv[3])):
        n=i
        #m=random.randint(n-1,min((n*(n-1))/2,2*n))
        G=gen_graph(n)
        filename='n='+str(n)+',m='+str(len(G.edges()))
        file=open(filename+'.rkt','w')
        file.write('#lang racket\n(require "./../../graph.rkt")\n(define graph (initialize_graph))\n')
        instant_write('(define (insert)\n',file)
        for j in range(i):
            instant_write('(add_node graph ' + str(j) +')\n',file)
        for (u,v) in G.edges():
            instant_write('(add_edge graph '+str(u)+' '+str(v)+' '+str(G.edges[u,v]['weight'])+')\n',file)
        src=0
        for j in range(i):
            if G.degree(j)>G.degree(src):
                src=j
        instant_write(')\n(insert)\n(define distance_list (shortest_path graph  '+str(src)+' 0))',file)
        instant_write('''\n;; WRITE DISTANCE LIST TO FILE;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define outfile (open-output-file \"'''+filename+'.out\"'+''' #:exists \'truncate))
(display "{" outfile) 
(hash-for-each distance_list
   (lambda (x y)
     (when (not (equal? y "inf")) (display (format "\\"~a\\":~a,\n" x y) outfile))))
(display "\\"null\\":\\"null\\"}" outfile)
(close-output-port outfile)''',file)
        file.close()
        file=open(filename+'.ans','w')
        file.write(json.dumps(nx.single_source_dijkstra_path_length(G,src)))
        #generate_file()
        #print (G.edges.data())
        os.system('./test.sh')
        file=open(filename+'.ans','r')
        ans=json.load(file)
        file=open(filename+'.out','r')
        out=json.load(file)
        out.pop('null')
        ans=json.dumps(ans,sort_keys=True)
        out=json.dumps(out,sort_keys=True)
        if (ans!=out):
            file=open('WA','a+')
            file.write(filename+'\n')
            break
        file.close() 
        file=open(filename+'.analysis','r')
        coordinate=file.readlines()
        file.close()
        [elapsedTime,MaxMem]=list(map(lambda x: x[:-1],coordinate))
        #print (elapsedTime,MaxMem)
        times.append(elapsedTime)
        memory.append(MaxMem)
        #os.system('rm n=*')
        print (str(i*100/int(sys.argv[2])) +" %",elapsedTime,MaxMem)
    file=open('time','wb')
    #pickle.dump(times,file)
    file=open('memory','wb')
    #pickle.dump(memory,file)
    file.close()
