Utils.insertCSS('@import url(https://fonts.googleapis.com/css?family=Ubuntu);')

bg = new BackgroundLayer
	
# Navigation

tabIconWidths = [21, 21, 25, 20]
tabIconHeights = [17, 17, 16, 16]

iconHome = "&#xf015;"
iconDashboard = "&#xf0e4;"
iconHouseSit = "&#xf236;"
iconMessages = "&#xf0e0;"
iconLocation = "&#xf041;"
iconCalendar = "&#xf073;"
iconMessages = "&#xf0e0;"

tabColour = "#808080"
tabColourActive = "#6699CC"

tabIconsMainNavigation = [iconHome, iconDashboard, iconHouseSit, iconMessages]
tabIconsDetailNavigation = [iconLocation, iconCalendar, iconMessages]

mainNavigationTabs = ["Home", "Dashboard", "House sit", "Messages"]
detailViewTabs = ["Location", "Calendar", "Messages"]

# Create our navigation class which extends the Framer Layer class
class Navigation extends Layer
	constructor: (options, resolution, @tabNames, @tabIcons, @tabIconWidths, @tabIconHeights, @activeTab) ->
		
		# empty array to store our tabs 
		@tabs = []
		
		# Our default font and icon colour
		@fontColour = tabColour
		
		@fontColourActive = tabColourActive
		
		isTabActive = false

		# amount of tabs
		amount = @tabNames.length
		
		# functionality to make the tabs/inactive 		
		@tabClickingFunctionality = (el) ->
			for layer in el.children
				layer.style = 'color': @fontColourActive
			for layer in el.siblings
				for child in layer.children
					child.style = 'color': @fontColour

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
				
			@tabs.push Navigation.tab

			Navigation.icon = new Layer
				name: "icon"
				parent: @tabs[i]
				x: Align.center()
				y: 10
				width: @tabIconWidths[i] * resolution
				height: @tabIconHeights[i] * resolution
				html: @tabIcons[i]
				backgroundColor: null
			Navigation.icon.style =
				"font-family": 'FontAwesome'
				"font-size": "63px" 
				"color": "#{@fontColour}"
				"padding-top": "20px"
				
			Navigation.label = new Layer
				name: "label"
				parent: @tabs[i]
				width: @tabs[i].width
				y: 30
				html: @tabNames[i]
				backgroundColor: null
			Navigation.label.style =
				"font-family": 'Ubuntu'
				"font-size": "36px"
				"text-align": "center"
				"padding-top": "60px" 
				"color": "#{@fontColour}"
			
class staticNavigation extends Navigation
	constructor: ->
		super(null, 3, mainNavigationTabs, tabIconsMainNavigation, tabIconWidths, tabIconHeights)
		
		# Set the second tab to active 		
		@tabClickingFunctionality(@tabs[1])
		
class functionalNavigation extends Navigation
	constructor: ->
		super(null, 3, detailViewTabs, tabIconsDetailNavigation, tabIconWidths, tabIconHeights)
		
		for tab in @tabs
			tab.onTap ->
				for layer in @.children
					layer.style = 'color': tabColourActive
				for layer in @.siblings
					for child in layer.children
						child.style = 'color': tabColour
			@tabClickingFunctionality(@)
		
mainNavigation = new staticNavigation()
detailNavigation = new functionalNavigation()
