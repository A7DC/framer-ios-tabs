Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Ubuntu);')

bg = new BackgroundLayer
	
tabIconWidths = [21, 21, 25, 20]
tabIconHeights = [17, 17, 16, 16]

iconHome = "&#xf015;"
iconDashboard = "&#xf0e4;"
iconHouseSit = "&#xf236;"
iconMessages = "&#xf0e0;"

tabColour = "#808080"

tabIcons = [iconHome, iconDashboard, iconHouseSit, iconMessages]


# Create our navigation class which extends the Framer Layer class
class Navigation extends Layer
	constructor: (options, resolution, @tabNames, @tabIcons, @tabIconWidths, @tabIconHeights) ->
		
		# empty array to store our tabs 
		tabs = []
		
		# Our default font and icon colour
		fontColour = "#808080"
		
		fontColourActive = "#6699CC"
		
		isTabActive = false
		
		# amount of tabs
		amount = @tabNames.length

		# inherit Layer's'default options and merge with the options provided to the constructor
		super _.defaults options,
			width: Screen.width
			height: 49 * resolution
			y: Screen.height - (49 * resolution)
			backgroundColor: "FFFFFF"
			style: "box-shadow": "0px -2px 4px 0px rgba(0,0,0, 0.2)"
			
		for i in [0...amount]
			Navigation.tab = new Layer
				parent: @
				width: Screen.width / amount
				height: @.height
				x: (Screen.width / amount) * i
				backgroundColor: null
				name: @tabNames[i].replace(/\s/g, '');
				
			tabs.push Navigation.tab

			Navigation.icon = new Layer
				name: "icon"
				parent: tabs[i]
				x: Align.center()
				y: 10
				width: @tabIconWidths[i] * resolution
				height: @tabIconHeights[i] * resolution
				html: @tabIcons[i]
				backgroundColor: null
			Navigation.icon.style =
				"font-family": 'FontAwesome'
				"font-size": "63px" 
				"color": "#{fontColour}"
				"padding-top": "20px"
				
			Navigation.label = new Layer
				name: "label"
				parent: tabs[i]
				width: tabs[i].width
				y: 30
				html: @tabNames[i]
				backgroundColor: null
			Navigation.label.style =
				"font-family": 'Ubuntu'
				"font-size": "36px"
				"text-align": "center"
				"padding-top": "60px" 
				"color": "#{fontColour}"
				
			do (i) ->
				tabs[i].onTap ->
					for layer in @.children
						layer.style = 'color': fontColourActive
					for layer in @.siblings
						for child in layer.children
							child.style = 'color': fontColour
							
				
mainNavigationTabs = ["Home", "Dashboard", "House sit", "Messages"]

mainNavigation = new Navigation(null, 3, mainNavigationTabs, tabIcons, tabIconWidths, tabIconHeights)