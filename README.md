Games Programming Assignment 2 2023. 

# Project Title: The Matrix

Group: Luke Noone, Peter Kavanagh, Oscar Jarvis, Evan Long.

Student Number: 
- C22532639
- 
- 
- 

## Description of the project:
Our project is a creative look at diving into the Matrix, using facial racognition security we are fighting back against the rise of AI. 

## Instructions for use:
To get our project up and running, you will make sure you have Minim, OpenCV and Video Library for Processing 4 imported into the file. Also make sure to include ```import java.awt.*;``` (you do not need to import anything from the processing library for this). A working webcam is also necessary for our project. 

## How it works:

List of classes/assets in the project and whether made yourself or modified or if its from a source, please give the reference
Class/asset	Source
MyClass.cs	Self written
MyClass1.cs	Modified from reference
MyClass2.cs	From reference


References:

# What I am most proud of in the assignment:
## Luke:
I am most proud of learning how to use open.cv and processing video for this project so I could make the facial regonition authentication. It was also quite enjoyable setting up the sketch to have a security system using booleans. 
```Java
if(camScan == true && delayEnd == false)
  {
    delay(5000);
    
    translate(0, 0, 20);
    fill(0);
    rect(200, 450, 600, 100);
    
    textSize(30);
    fill(70, 255, 255);
    text(cont, 210, 520);
    delayEnd = true;
  }
```

## Evan:

## Oscar:

## Peter:


Proposal submitted earlier can go here:
This is how to markdown text:
This is emphasis

This is a bulleted list

Item
Item
This is a numbered list

Item
Item
This is a hyperlink

Headings
Headings
Headings
Headings
This is code:

public void render()
{
	ui.noFill();
	ui.stroke(255);
	ui.rect(x, y, width, height);
	ui.textAlign(PApplet.CENTER, PApplet.CENTER);
	ui.text(text, x + width * 0.5f, y + height * 0.5f);
}
So is this without specifying the language:

public void render()
{
	ui.noFill();
	ui.stroke(255);
	ui.rect(x, y, width, height);
	ui.textAlign(PApplet.CENTER, PApplet.CENTER);
	ui.text(text, x + width * 0.5f, y + height * 0.5f);
}
This is an image using a relative URL:

An image

This is an image using an absolute URL:

A different image

This is a youtube video:

YouTube

This is a table:

Heading 1	Heading 2
Some stuff	Some more stuff in this column
Some stuff	Some more stuff in this column
Some stuff	Some more stuff in this column
Some stuff	Some more stuff in this column
