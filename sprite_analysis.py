from PIL import Image
path = r'c:\Users\Yokin\OneDrive\Desktop\Looping Rooms\assets\Player_Sprite.png'
img = Image.open(path).convert('RGBA')
w,h = img.size
pix = img.load()
cols=[]
rows=[]
for x in range(w):
    cols.append(any(pix[x,y][3]>16 and sum(pix[x,y][:3])>10 for y in range(h)))
for y in range(h):
    rows.append(any(pix[x,y][3]>16 and sum(pix[x,y][:3])>10 for x in range(w)))
def runs(arr):
    r=[]
    inrun=False
    start=0
    for i,v in enumerate(arr):
        if v and not inrun:
            inrun=True
            start=i
        elif not v and inrun:
            inrun=False
            r.append((start,i-1))
    if inrun:
        r.append((start,len(arr)-1))
    return r
colruns=runs(cols)
rowruns=runs(rows)
print('size',w,h)
print('colruns first 20',colruns[:20])
print('rowruns first 20',rowruns[:20])
print('col widths unique',sorted({e-s+1 for s,e in colruns}))
print('row heights unique',sorted({e-s+1 for s,e in rowruns}))
print('first 10 col widths',[e-s+1 for s,e in colruns[:10]])
print('first 10 row heights',[e-s+1 for s,e in rowruns[:10]])
for fw in [32,40,44,48,56,64,72,80,88,96,104,112,128,144]:
    if w % fw == 0:
        print('fw candidate',fw,w//fw)
for fh in [32,40,44,48,56,64,72,80,88,96,104,112,128,144,160,176,192,256]:
    if h % fh == 0:
        print('fh candidate',fh,h//fh)

