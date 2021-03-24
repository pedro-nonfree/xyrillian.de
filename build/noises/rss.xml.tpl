{{- .XMLIntro }}
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom">
{{- $show := index .Shows .CurrentShowID }}
<channel>
  <title>{{$show.Title}}</title>
  <link>{{$show.URL}}</link>
  <atom:link href="https://xyrillian.de/{{$show.FeedPath}}" rel="self" type="application/rss+xml" />
  <language>de</language>
  <copyright>&#xA9; 2018 Stefan Majewsky</copyright>
  <itunes:subtitle>{{$show.Subtitle}}</itunes:subtitle>
  <itunes:author>Xyrillian Noises</itunes:author>
  <itunes:summary>{{$show.Description}}</itunes:summary>
  <description>{{$show.Description}}</description>
  <itunes:type>episodic</itunes:type>
  <itunes:owner>
  <itunes:name>Stefan Majewsky</itunes:name>
  <itunes:email>majewsky@posteo.de</itunes:email>
  </itunes:owner>
  <image>
    <url>https://xyrillian.de/res/{{$show.Covers.ForFeed}}</url>
    <link>{{$show.URL}}</link>
    <title>Coverart</title>
  </image>
  <itunes:image href="https://xyrillian.de/res/{{$show.Covers.ForFeed}}"/>
  <itunes:category text="{{$show.Category}}"/>
  <itunes:explicit>no</itunes:explicit>
  {{- range (.Files | reverseFiles) }}
  {{- if eq .ShowID $.CurrentShowID }}
  <item>
    <itunes:episodeType>{{if .Episode}}full{{else}}bonus{{end}}</itunes:episodeType>
    <itunes:title>{{.Title}}</itunes:title>
    {{- if .Episode }}
    <itunes:episode>{{.Episode}}</itunes:episode>
    {{- end }}
    <itunes:season>1</itunes:season>
    <title>{{.Title}}</title>
    <itunes:author>Xyrillian Noises</itunes:author>
    <itunes:subtitle></itunes:subtitle>
    <itunes:summary>{{.RSS.Description}}</itunes:summary>
    <description>{{.RSS.Description}}</description>
    <content:encoded>{{.RSS.ShowNotes}}</content:encoded>
    {{- range .Downloads }}
    {{- if ne .Format "FLAC" }}
      <enclosure length="{{.SizeBytes}}" url="https://xyrillian.de/dl/{{.FileName}}" type="{{.MIMEType}}"/>
    {{- end }}
    {{- end }}
    <guid>https://xyrillian.de/id/{{.ShowID}}/{{if .Episode}}{{printf "%03d" .EpisodeAsInt}}{{else}}{{.Slug}}{{end}}/</guid>
    <pubDate>{{.PublicationTimeUnix | unixTimeToRFC1123 }}</pubDate>
    <itunes:duration>{{.LengthSeconds | readableLengthSeconds}}</itunes:duration>
    <itunes:explicit>no</itunes:explicit>
  </item>
  {{- end }}
  {{- end }}
</channel>
</rss>
