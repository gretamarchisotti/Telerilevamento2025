# **Progetto d'esame (09/07/2025)**
# Analisi di un'area canadese soggetta a incendio nella primavera 2025
### Telerilevamento geologico in R
Greta Marchisotti

---

## Introduzione
Il progetto ha lo scopo di analizzare un'area del Canada, al confine tra le regioni Manitoba e Saskatchewan, a nord della cittadina Flin Flon, che nella primavera del 2025 è stata oggetto di un ampio incendio.

L'analisi vuole osservare le differenze in termini di vegetazione tra il 2024 e il 2025 e valutare quindi l'impatto dell'incendio stesso.

Sono state pertanto scelte due immagini di Sentinel-2, che riguardano una media di giugno 2024 e una media di giugno 2025.

## Raccolta delle immagini
Le immagini sono state scaricate attraverso il sito web di [Google Earth Engine](https://earthengine.google.com/), scegliendo l'area descritta precedentemente.

> [!NOTE]
>
> Il codice completo in java script utilizzato per ottenere le immagini si trova nel file Codice_js_GM.js

## Pacchetti utilizzati
I pacchetti di R che sono stati utilizzati per questo codice sono i seguenti:
```r
library(terra) # Paccheto per l'analisi spaziale dei dati con vettori e dati raster
library(imageRy) # Pacchetto per manipolare, visualizzare ed esportare immagini raster in R
library(viridis) # Pacchetto per cambiare le palette di colori anche per chi è affetto da colorblindness
library(ggplot2) # Pacchetto per creare grafici ggplot
library(patchwork) # Pacchetto utilizzato per comporre più grafici ggplot insieme
```

## Impostazione della working directory e importazione delle immagini
```r
setwd("C:/Users/march/Desktop/BOLOGNA/II semestre/Telerilevamento geoecologico in R/ESAME")

sentinel2024 <- rast("Canada2024.tif")
sentinel2024

sentinel2025 <- rast("Canada2025.tif")
sentinel2025
```

> [!NOTE]
>
> Il raster sentinel2024 corrisponde ai dati di giugno 2024, mentre sentinel2025 riguarda i dati di giugno 2025.

Le immagini importate sono state poi visualizzate nello spettro del visibile, creando un pannello multiframe per permettere un migliore confronto.
```r
im.multiframe(1,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
dev.off()
```

L'immagine risultante è la seguente:
<img src="../ESAME/Immagini/CanadaRGB.png" />
> L'immagine mostra chiaramente l'area soggetta a incendio, che corrisponde alla porzione inferiore dell'immagine di sinistra.

---

## Analisi dei dati
### Visualizzazione delle bande
È stato creato un grafico per mostrare le differenti bande scelte per le immagini: la banda 4 corrisponde al colore rosso, la banda 3 al verde, la banda 2 al blu e la banda 8 all'infrarosso vicino (NIR); per i grafici è stata scelta la palette di viridis chiamata magma.
```r
plot(sentinel2024, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))
plot(sentinel2025, main=c("B4-Red", "B3-Green", "B2-Blue", "B8-NIR"), col=magma(100))
```

Per quanto riguarda il 2024, il risultato è il seguente:
<img src="../ESAME/Immagini/Bande2024.png" /> 

Per quanto riguarda il 2025, invece, il risultato è:
<img src="../ESAME/Immagini/Bande2025.png" />

> Da entrambe le immagini si può notare come, mentre le bande 4, 3 e 2 sono abbastanza simili tra loro, la banda 8, e cioè il NIR, risulta essere molto diversa: è infatti la banda che ci permette di visualizzare al meglio la vegetazione.
> 
> Se la vegetazione è sana, la riflettanza sarà maggiore nell'infrarosso vicino (NIR); viceversa, se la vegetazione è sottoposta a stress, come un incendio,  la riflettanza del NIR diminuisce: i valori del NIR del 2025 sono, infatti, molto più bassi nell'area soggetta a incendio.

È stato poi scelto di visualizzare le immagini con il NIR, ponendo la banda 8 al posto della banda del rosso e plottando le immagini in un pannello multiframe, insieme a quelle visualizzate nello spettro del visibile. Il codice è il seguente: 
```r
im.multiframe(2,2)
plotRGB(sentinel2024, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2024")
plotRGB(sentinel2025, r = 1, g = 2, b = 3, stretch = "lin", main = "Sentinel-2 (median) 2025")
im.plotRGB(sentinel2024, r=4, g=1, b=3)
im.plotRGB(sentinel2025, r=4, g=1, b=3)
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
```

Si ottiene in questo modo l'immagine riportata qui di seguito:
<img src="../ESAME/Immagini/CanadaRGB_NIR.png" />

> Le immagini in basso sono quelle in cui è visualizzata la banda del NIR che, essendo stata inserita al posto della banda red, permette di visualizzare la vegetazione in rosso. Questa banda è infatti la più indicata per visualizzare la vegetazione e le diverse sfumature di rosso corrispondono a diverse tipologie di vegetazione. Il suolo nudo appare invece in azzurro chiaro.

### Indici spettrali: NDVI
È stato calcolato il Normalized Difference Vegetation Index (NDVI), cioè un indice per la vegetazione dato dalla differenza tra la riflettanza nel NIR e la riflettanza nel red, che è stato standardizzato, in modo che sia svincolato dalla risoluzione radiometrica in entrata e quindi in modo che il range vada sempre da +1 a -1, a prescindere dal numero di bit dell’immagine.

Siccome la vegetazione sana riflette molto nell'infrarosso vicino e poco nel red, il suo NDVI avrà valori molto alti; viceversa, la vegetazione stressata avrà una riflettanza minore nel NIR e maggiore nel red e quindi il suo NDVI sarà più basso.

Il codice per calcolare l'NDVI nelle immagini è il seguente e le immagini sono state plottate in un pannello multiframe con la palette rocket di viridis:
```r
ndvi2024 = im.ndvi(sentinel2024, 4, 1)
ndvi2025 = im.ndvi(sentinel2025, 4, 1)

im.multiframe(2,1)
plot(ndvi2024, col=rocket(100), main="NDVI 2024")
plot(ndvi2025, col=rocket(100), main="NDVI 2025")
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
```

L'immagine che si ottiene è la seguente:

<img src="../ESAME/Immagini/CanadaNDVI.png" /> 

> Come accennato precedentemente, l'NDVI ha valori più bassi nell'area soggetta a incendio, rispetto alla stessa area del 2024.

### Analisi multitemporale
Facendo un'analisi multitemporale è poi possibile confrontare le differenze tra l'immagine del 2024 e quella del 2025.

In questo caso, è stato scelto di confrontare le due immagini per quanto riguarda la banda del NIR e l'NDVI, per evidenziare le differenze relative in particolare alla vegetazione.

Le due immagini finali sono state plottate insieme in un pannello multiframe, scegliendo la palette di viridis chiamata mako.

```r
canada_diff = sentinel2024[[4]]-sentinel2025[[4]]
ndvi_diff = ndvi2024-ndvi2025

im.multiframe(1,2)
plot(canada_diff, col=mako(100), main="NIR")
plot(ndvi_diff, col=mako(100), main="NDVI")
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
```
> [!NOTE]
>
> Il file canada_diff rappresenta la differenza tra la banda del NIR del 2024 e del 2025, mentre il file ndvi_diff è dato dalla differenza dell'NDVI per il 2024 e il 2025.


Il risultato è il seguente:
<img src="../ESAME/Immagini/Diff_NIR_NDVI.png" /> 

> Osserviamo come la differenza è maggiore nell'area soggetta a incendio sia per quanto riguarda la banda del NIR che per quanto riguarda l'NDVI, mentre il resto dell'area è rimasta pressochè uguale.

### Classificazione delle immagini
Infine, è stato scelto di classificare le immagini in due classi corrispondenti all'area coperta da vegetazione e tutta la restante area, composta principalmente da laghi, suolo nudo e dall'area dell'incendio nell'immagine del 2025.

Per fare ciò, è stato innanzitutto aperto un pannello multiframe per permette la visualizzazione delle immagini insieme, ed è stata poi utilizzata la funzione im.classify() di imageRy, creata appositamente per questo tipo di classificazioni.
Le immagini che sono state scelte sono quelle iniziali, comprendenti tutte e quattro le bande (RGB e NIR).

```r
# Creo un multiframe per osservare le due immagini classificate insieme
im.multiframe(1,2)

# Classifico le due immagini in due classi (class 1; class 2)
sentinel2024_cl = im.classify(sentinel2024, num_clusters=2)
sentinel2025_cl = im.classify(sentinel2025, num_clusters=2)
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
```

Di seguito si riporta l'immagine ottenuta:
<img src="../ESAME/Immagini/Classification.png" /> 

> In blu si osserva l'area vegetata (class 2), mentre in giallo (class 1) tutto ciò che non è vegetato.
>
> Notiamo come nell'immagine di sinistra, che corrisponde al 2025, la percentuale di pixel appartenenti alla classe 1 sono notevolmente aumentati, a causa dell'incendio.

Questo si può osservare anche calcolando la percentuale delle due classi nelle immagini:
```r
perc2024 = freq(sentinel2024_cl)*100/ncell(sentinel2024_cl)
perc2024 # Foresta: 76%, Altro: 24%

perc2025 = freq(sentinel2025_cl)*100/ncell(sentinel2025_cl)
perc2025 # Foresta: 51%, Altro: 49%
```
> I risultati mostrano come la percentuale di foresta sia scesa dal 76% al 51% dal 2024 al 2025 a causa dell'incendio.

È stato quindi creato un grafico con ggplot() per visualizzare graficamente questa differenza: per fare ciò è stato necessario prima creare un data frame con i valori necessari; i due grafici sono poi stati plottati uno di fianco all'altro grazie al pacchetto patchwork.
```r
# Creo una tabella con i risultati
classi = c("Forest", "Everything else")
a2024 = c(76,24)
a2025 = c(51,49)
tab = data.frame(classi, a2024, a2025)

# Creo i due grafici e li inserisco uno accanto all'altro, aggiustando le scale
p1 = ggplot(tab, aes(x=classi, y=a2024, fill=classi, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p2 = ggplot(tab, aes(x=classi, y=a2025, fill=classi, color=classi)) + geom_bar(stat="identity", fill="white") + ylim(c(0,100))
p1 + p2
dev.off() # Chiudo il pannello grafico dopo aver salvato l'immagine in .png
```

Si riportano i risultati in una tabella:

| Classe       | 2024 | 2025 |
|---           |---   |---   |
|   1: Altro   |  24  |  49  |
|   2: Foresta |  76  |  51  |

Il grafico, invece, è il seguente:

<img src="../ESAME/Immagini/Class_plot.png" /> 

---

## Conclusioni
+ L'area soggetta a incendio mostra una forte diminuzione della copertura vegetativa, come visto dal valore dell'NDVI e dalla differenza nella riflettanza nell'infrarosso vicino.
+ Le immagini qui analizzate riguardano solo una piccola porzione di tutta l'area che è stata impattata dagli incendi della primavera 2025: per un'analisi su più larga scala è necessario scaricare immagini complete di tutte le regioni di Manitoba e Saskatchewan.
+ Queste aree sono soggette a incendi annuali: le immagini del 2024 mostrano però una vegetazione tuttosommato sana e la porzione di suolo nudo è ridotta. Questo probabilmente è dovuto a un adattamento della vegetazione di queste zone a questo tipo di disturbo, nonostante gli impatti sul breve periodo siano notevoli. Un ulteriore sviluppo di queste analisi potrebbe riguardare il confronto dell'impatto degli incendi nei vari anni e non solo di quelli del 2025.
+ Il telerilevamento e l'analisi dei dati attraverso le bande di riflettanza e gli indici spettrali sono un valido strumento per analizzare i dati da satellote e valutare gli impatti che fenomeni come gli incendi possono avere su vaste aree.
