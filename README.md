UIToast
=======

Enjoy the IOS UIToast -- by Jack Chen

How to use:
1.Download UIToast(.h and .m) and UIRotateViewController(.h and .m).
2.Add downloaded files to your project.
3.Use following code to show a toast:

UIToast* toast = [[UIToast alloc] init];
[toast showToast:@"Enjoy the UIToast!" tiemInterval:4.0];
[toast release];
