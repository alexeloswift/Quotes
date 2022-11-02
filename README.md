# Welcome to the Quotes App
This app displays a slideshow of Star Wars quotes to the user. 

## Specs & Design
- I built this app using a UI framework of my choice (SwiftUI).   
- The quotes that need to be displayed are available in a JSON array.  
- Each element of the array contains the quote, its author, as well as the time that it needs to be displayed.  
- Each quote is displayed for the specified amount of time, and the screen is updated to show the next quote. At the end of the slideshow, the view loops back to the first slide.  

## Implementation
This app was built using SwiftUI, some Combine & the MVVM design pattern.
### Model
The model consist of the quote properties.
```swift
struct QuoteModel {
    let quote: String
    let author: String
    let slideTransitionDelay: Int
}
```

### Viewmodel
The viewmodel consist of my business logic most importantly the method that makes the slide changes.
```swift
    func updateQuote() {
        if currentSlide < 3 && currentSlide > -1 {
            self.currentQuote = quotesData[currentSlide]
            currentSlide += 1
            timeLeft = Double(currentQuote.slideTransitionDelay) / 1000
        } else if currentSlide == 3 {
            self.currentQuote = quotesData[currentSlide]
            timeLeft = Double(currentQuote.slideTransitionDelay) / 1000
            currentSlide = 0
        }
    }
```

### View
The view contains all of my UI logic including the timer that triggers the slide change.
```swift
    var body: some View {
        NavigationView {
            ZStack {
                let timer = Timer.publish(every: viewmodel.timeLeft, on: .main, in: .common).autoconnect()
                starWarsImage
                VStack {
                    quote
                    author
                }
                .padding()
                .rotationEffect(.degrees(angle))
                .animation(.easeOut(duration: 0.7) , value: angle)
                .onReceive(timer) { _ in
                    viewmodel.updateQuote()
                    angle += 360
                }
                .navigationTitle("Star Wars Quotes")
            }
        }
    }
```

## Screen Recording
Here is screen recording that shows exactly what I'm talking about. As you can see the quote changes every certain amount of seconds (the amount of seconds change depending on the quote).
<div align="center"> 
    <img src="https://user-images.githubusercontent.com/88692767/199358677-488707bc-07aa-4932-80b3-22e067fb5cb0.gif" />
</div>
<div align="center">
(P.S. sorry for the gif quality, GitHub only lets us upload a file with a file size of max 10mb)
</div>

## Testing
Testing was pretty simple with this project because I only had one method to test.   
This test is checking that the values before and after `viewmodel.updateQuote()` is called are correct. Making sure the the updateQuote function is working as expected.


```swift
    func testupdateQuote() {
        // testing initial state of currentQuote

        XCTAssertEqual(viewmodel.currentSlide, 0)
        XCTAssertEqual(viewmodel.currentQuote.slideTransitionDelay, 3000)
        XCTAssertEqual(viewmodel.timeLeft, 0)

        viewmodel.updateQuote()

        // testing currentQuote after being updated

        /// These values are published to QuotesView
        XCTAssertEqual(viewmodel.currentQuote.slideTransitionDelay, 3000)
        XCTAssertEqual(viewmodel.timeLeft, 3)

        /// This value is in preparation to update quote again
        XCTAssertEqual(viewmodel.currentSlide, 1)
    }
  ````


## Things I learned 
Before this project I had only worked with timers one time. That being said, this project gave me the opportunity to learn a little more about timers! For example, I learned that time intervals are a get only property. 
This means that we can't really make a timer with dynamic time intervals, which is what I first tried to do 🥲

So to solve this issue I needed to make a property that would call the timer with the updated time interval everytime the timer published.

This allowed me to create the loop effect for the slides.

## Conclusion
All in all this small project was pretty fun! I'm glad I got to learn some more about timers.

