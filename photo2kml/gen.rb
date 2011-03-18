#!/bin/env ruby
require 'rubygems'
require 'exifr'
#  dirname = "./(GPS案例)2011-02-27台南逛街"
#  name="(GPS案例)2011-02-27台南逛街"
dirname = "./(GPS案例)2011-02-28苗栗燈會/"
name= "(GPS案例)2011-02-28苗栗燈會/"
header='<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
  <Document>
    <name>'+name+'</name>
    <description>Examples of paths. Note that the tessellate tag is by default
      set to 0. If you want to create tessellated lines, they must be authored
      (or edited) directly in KML.</description>
    <Style id="yellowLineGreenPoly">
      <LineStyle>
        <color>7f00ffff</color>
        <width>8</width>
      </LineStyle>
      <PolyStyle>
        <color>7f00ff00</color>
      </PolyStyle>
    </Style>
    '
        print header
        count=0
        end_lat=0.0
        end_lon=0.0
placemarks=[]
filenames=[]
Dir.entries(dirname).each{|f|
    if File.file?("#{dirname}/#{f}")
        obj=EXIFR::JPEG.new("#{dirname}/#{f}")
        lat=0.0
        lon=0.0
        if obj.exif.gps_latitude
            lat = obj.exif.gps_latitude[0].to_f + (obj.exif.gps_latitude[1].to_f / 60) + (obj.exif.gps_latitude[2].to_f / 3600)
            lat = lat * -1 if obj.exif.gps_latitude_ref == 'S' 
            long = obj.exif.gps_longitude[0].to_f + (obj.exif.gps_longitude[1].to_f / 60) + (obj.exif.gps_longitude[2].to_f / 3600)   
            long = long * -1 if obj.exif.gps_longitude_ref == 'W' 
            end_lat=lat
            end_lon=long
            placemarks.push([long,lat])
            filenames.push f
            if count==0
               print "<Placemark>
      <name>start</name>
      <description>
        <![CDATA[
          <h1>start</h1>
        ]]>
      </description>
      <Point>
        <coordinates>#{long},#{lat}</coordinates>
      </Point>
    </Placemark>" 
    print '<Placemark>
      <name>Absolute Extruded</name>
      <description>Transparent green wall with yellow outlines</description>
      <styleUrl>#yellowLineGreenPoly</styleUrl>
      <LineString>
        <extrude>1</extrude>
        <tessellate>1</tessellate>
        <altitudeMode>absolute</altitudeMode>'
        print " <coordinates>"
            end
#              print "#{lat},#{long},2357\n"
            print "#{long},#{lat},100\n"
        end
       count+=1 
    end
}

        print " </coordinates>"
        print'</LineString>
    </Placemark>'
 print "<Placemark>
      <name>end</name>
      <description>
        <![CDATA[
          <h1>end</h1>
        ]]>
      </description>
      <Point>
        <coordinates>#{end_lon},#{end_lat}</coordinates>
      </Point>
    </Placemark>" 
    #產生每個位置的點
    for ii in (0...placemarks.size)
  print "<Placemark>
      <name>#{ii}</name>
      <description>
        <![CDATA[
          <h1>#{filenames[ii]}</h1>
        ]]>
      </description>
      <Point>
        <coordinates>#{placemarks[ii][0]},#{placemarks[ii][1]}</coordinates>
      </Point>
    </Placemark>" 
    end
footer='
  </Document>
</kml>'
print footer
