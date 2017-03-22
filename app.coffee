# Create our navigation class which extends the Framer Layer class
class Navigation extends Layer
	constructor: (options, resolution, @tabNames) ->
		
		# empty array to store our tabs 
		tabs = []
		
		# amount of tabs
		amount = @tabNames.length

		# inherit Layer's'default options and merge with the options provided to the constructor
		super _.defaults options,
			width: Screen.width
			height: 49 * resolution
			y: Screen.height - (49 * resolution)
			
		for i in [0...amount]
			Navigation.tab = new Layer
				parent: @
				width: Screen.width / amount
				height: @.height
				x: (Screen.width / amount) * i
				backgroundColor: Utils.randomColor()
				name: "tab" + (i+1)
				
			tabs.push Navigation.tab

			Navigation.icon = new Layer
				name: "icon"
				parent: tabs[i]
				x: Align.center()
				y: 10
				width: 20 * resolution
				height: 20 * resolution
				
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

mainNavigationTabs = ["Home", "Dashboard", "House sit", "Messages"]
detailViewTabs = ["Location", "Calendar", "Messages"]

mainNavigation = new Navigation(null, 3, mainNavigationTabs)

# detailViewNavigation = new Navigation(null, 3, detailViewTabs)



