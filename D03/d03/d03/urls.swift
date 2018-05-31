//
//  File.swift
//  photo_multithread
//
//  Created by Sydney COHEN on 5/31/18.
//  Copyright © 2018 Sydney COHEN. All rights reserved.
//

import Foundation

let images : [String] = [
    "https://scontent-cdt1-1.cdninstagram.com/vp/0106996440a3887b1a3d414f82dfa0d9/5BA4B39E/t51.2885-15/e35/32247639_209572693103635_6253219478121742336_n.jpg",
    "https://scontent-cdt1-1.cdninstagram.com/vp/7347f2bec6ec27297213a91c2fc15c1e/5B9E4484/t51.2885-15/e35/31412268_2056690504605796_6992114918602309632_n.jpg",
    "https://scontent-cdt1-1.cdninstagram.com/vp/bb40bf8f80c324d795011088a8a70cb9/5BAC92F6/t51.2885-15/e35/30602343_1178350578968360_2219657665716420608_n.jpg",
    "https://thumb.grindnetworks.com/-R_M_HInq4V-F30MYjm4YmHz2Eo=/1200x0/filters:format(jpg):quality(80):max_bytes(500000):sharpen(0.2%2C1%2Cfalse):strip_exif():strip_icc()/https://cdn.surfer.com/uploads/2017/12/B8A4353_BW_v3.jpg",
    "https://thumb.grindnetworks.com/_KgGiRXo9Mxc7_BVVfJHvD3Y8V4=/2000x0/filters:format(jpg):quality(80):max_bytes(500000):sharpen(0.2%2C1%2Cfalse):strip_exif():strip_icc()/https://cdn.surfer.com/uploads/2017/12/AJ1Y8988.jpg",
    "https://thumb.grindnetworks.com/3cl9wFS7q7T6S2MiDYULnpbkki4=/2000x0/filters:format(jpg):quality(80):max_bytes(500000):sharpen(0.2%2C1%2Cfalse):strip_exif():strip_icc()/https://cdn.surfer.com/uploads/2017/12/SRFP-170600-PROXSPR-029-2.jpg",
    "https://www.nasa.gov/sites/default/files/styles/full_width/public/thumbnails/image/e0102_lg.jpg?itok=sd9lOayI",
    "https://www.error.error",
    ]

var numberOfImagesLoaded = 0;

