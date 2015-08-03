# SCPopupViewController

Is a library that provide an easy way to create custom popups. 
It is contain two main clases:

###### 1. SCPopupViewController:
Is the the popup view, that consist of a overlay transparent view that ocuppy the whole screen, and the container view where your custom popup will be inside.


###### 2. SCPopupContainerViewController
Is the view that will be inside the popup.
Inherit your custom container from this class, and init the popup with it. Automatically the popup will be adapt to the size of the container.

##### Tips:

- Use the close action to close the popup with a button inside your container:
```
[self.closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
```

- If your container contain UITextFields the popup will be automatically move up or down when the keyboard appear.


##### How to use it?

```
ContentPopupViewController *contentVC = [ContentPopupViewController new];

SCPopupViewController *popup = [[SCPopupViewController alloc] initWithContentView:contentVC onTargetViewController:self]; 

[popup show];
```





