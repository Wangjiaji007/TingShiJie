//
//  Channel.swift
//  TingShiJie
//
//  Created by Jiaji Wang on 4/7/15.
//  Copyright (c) 2015 Jiaji Wang. All rights reserved.
//

import Foundation

class Channel{
	
	var name: String?
	var info: String?
	var url: String?
	
	init(name: String, info: String, url: String){
		self.name = name
		self.info = info
		self.url  = url
	}
}