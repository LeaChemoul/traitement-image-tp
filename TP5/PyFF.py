#!/usr/bin/python3
import cv2
import numpy as np

# single or double panel? choose here
DOUBLEPANEL = True

# default values
display = "img"
# no windowing
apod_size = 0
# not drawing a mask
drawing = False
# drawing non-symetric mask
symetric_mask = False

########################################################################
# apodization
def apodization(apod_size):
    if apod_size > 0:
        halfhann = 1/2+1/2*np.cos(np.linspace(0, np.pi, apod_size))
        row = np.ones((shape[0], 1))
        row[:apod_size, 0] = halfhann[::-1]
        row[-apod_size:, 0] = halfhann
        col = np.ones((1, shape[1]))
        col[0, :apod_size] = halfhann[::-1]
        col[0, -apod_size:] = halfhann
        return (np.dot(row, np.ones(col.shape))
                *np.dot(np.ones(row.shape), col))
    else:
        return np.ones(shape)

########################################################################
# image and Fourier utilities
def rgb2gray(rgb):
    r, g, b = rgb[:,:,0], rgb[:,:,1], rgb[:,:,2]
    gray = 0.2989 * r + 0.5870 * g + 0.1140 * b
    return np.uint8(gray)

def img2fou(gray):
    return np.fft.fft2(gray*window)

def fou2spec(fou, mask):
    fshift = np.fft.fftshift(fou)
    spec_brut = np.log(np.abs(fshift))
    M = spec_brut.max()
    return np.uint8(mask*255*spec_brut/M)

def fou2filt(fou, mask):
    fftfilt = fou*np.fft.ifftshift(mask)
    imgfilt = np.fft.ifft2(fftfilt)
    imgreal = np.abs(imgfilt) # abs to deal with non symetric filters
    M = imgreal.max()
    return np.uint8(255*imgreal/M)

########################################################################
# masking utilities
def createmask(size, typ="lp"): # computes LP or HP filter
    rowidx, colidx = np.indices(shape)
    distancefrom0 = np.sqrt((rowidx-point0[0])**2+(colidx-point0[1])**2)
    mask = np.zeros(shape)
#   square version
#    mask[(point0[0]-size):(point0[0]+size+1),
#         (point0[1]-size):(point0[1]+size+1)] = 1
#   circle version
    mask[distancefrom0<=size] = 1
    if typ == "lp": # it's low pass
        return mask
    else: # it's high pass, invert
        return 1-mask

def draw_mask(event, x, y, flags, params): # draws a filter
    global drawing
    if DOUBLEPANEL or display == "fou":
        if event == cv2.EVENT_LBUTTONDOWN:
            drawing = True
        elif event == cv2.EVENT_MOUSEMOVE:
            if drawing == True:
                cv2.circle(mask, (x, y), 10,(0, 0, 255), -1)
        elif event == cv2.EVENT_LBUTTONUP:
            drawing = False
            cv2.circle(mask, (x, y), 10, (0, 0, 255), -1)

def draw_sym_mask(event, x, y, flags, params): # draws a symetric filter
    global drawing
    sym_x = shape[1] - x
    sym_y = shape[0] - y
    if DOUBLEPANEL or display == "fou":
        if event == cv2.EVENT_LBUTTONDOWN:
            drawing = True
        elif event == cv2.EVENT_MOUSEMOVE:
            if drawing == True:
                cv2.circle(mask, (x, y), 10,(0, 0, 255), -1)
                cv2.circle(mask, (sym_x, sym_y), 10,(0, 0, 255), -1)
        elif event == cv2.EVENT_LBUTTONUP:
            drawing = False
            cv2.circle(mask, (sym_x, sym_y), 10, (0, 0, 255), -1)

########################################################################
# help screen
help_data = ("     PyFF: Python Fourier Filter",
             "",
             "f/F: switch to Fourier spectrum",
             "h/H: display this help",
             "i/I: invert filter",
             "r/R: reset filter",
             "s/S: toggle symmetry in mask drawing",
             "w/W: change apodisation",
             "0-6: predefined filters",
             "q/Q: quit")
font                   = cv2.FONT_HERSHEY_SIMPLEX
fontScale              = 1
fontColor              = (255,255,255)
lineType               = 2

def help_screen():
    posx = 10
    posy = 40
    hscr = np.zeros(shape)
    for h in help_data:
        cv2.putText(hscr, h, (posx, posy), font, fontScale,
                    fontColor, lineType)
        posy += 30
    cv2.imshow("plot", 1-hscr)
    key = cv2.waitKey(20)
    while key not in [ord("q"), ord("Q"), ord("h"), ord("H"), 27]: #+ESC
        key = cv2.waitKey(20)
        
########################################################################
# webcam, openCV, mask and window initializations
cv2.namedWindow("plot")
if DOUBLEPANEL:
    cv2.namedWindow("fourier")
    cv2.setMouseCallback("fourier", draw_mask) # mask only on fourier
else:
    cv2.setMouseCallback("plot", draw_mask)
wc = cv2.VideoCapture(0)

if wc.isOpened(): # try to get the first image
    imgOK, image = wc.read()
    shape = rgb2gray(image).shape
    point0 = (shape[0]/2, shape[1]/2)
    mask = np.ones(shape)
    window = apodization(apod_size)
else:
    imgOK = False

########################################################################
# let's go !
while imgOK:
    image = rgb2gray(image)
    fou = img2fou(image)
    if DOUBLEPANEL:
        cv2.imshow("plot", fou2filt(fou, mask))
        cv2.imshow("fourier", fou2spec(fou, mask))
    else:
        if display == "img":
            image = fou2filt(fou, mask)
        else:
            image = fou2spec(fou, mask)
        cv2.imshow("plot", image)
    
    imgOK, image = wc.read()
    key = cv2.waitKey(20)
    if key == 27 or key == ord("q") or key == ord("Q"): # exit on ESC
        break
    if key == ord("w") or key == ord("W"): # w/W toggles windowing
        apod_size = (apod_size+10)%40
        window = apodization(apod_size)
    if key == ord("f") or key == ord("F"): # f/F toggles spectrum
        if display == "img":
            display = "fou"
        else:
            display = "img"
    if key == ord("i") or key == ord("I"): # i/I inverts mask
        mask = 1 - mask
    if key == ord("r") or key == ord("R"): # resets mask
        mask = np.ones(shape)
    if key == ord("s") or key == ord("S"): # toggles symetric drawing
        if symetric_mask:
            symetric_mask = False
            if DOUBLEPANEL:
                cv2.setMouseCallback("fourier", draw_mask)
            else:
                cv2.setMouseCallback("plot", draw_mask)
        else:
            symetric_mask = True
            if DOUBLEPANEL:
                cv2.setMouseCallback("fourier", draw_sym_mask)
            else:
                cv2.setMouseCallback("plot", draw_sym_mask)
    if key == ord("h") or key == ord("H"): # help screen
        help_screen()
    # pre-defined filters keys: 0-4
    if key == ord("0"): # no filtering
        mask = np.ones(shape)
    if key == ord("1"): # low pass, small
        mask = createmask(10, typ="lp")
    if key == ord("2"): # low pass, big
        mask = createmask(25, typ="lp")
    if key == ord("3"): # low pass, big
        mask = createmask(50, typ="lp")
    if key == ord("4"): # high pass, small
        mask = createmask(10, typ="hp")
    if key == ord("5"): # high pass, big
        mask = createmask(25, typ="hp")
    if key == ord("6"): # high pass, big
        mask = createmask(50, typ="hp")

########################################################################
# cleaning stuff
wc.release()
cv2.destroyWindow("plot")
cv2.destroyWindow("fourier")
