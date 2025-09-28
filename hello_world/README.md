# Jobsheet 5

Name : Agna Putra Prawira
NIM : 2341720065
Absent: 01

## Practical 1

### Step 1

This step is a quick way to access all available commands in VS Code, including those added by the Flutter extension.

1. Open the Visual Studio Code application.

2. Press the keys Ctrl + Shift + P simultaneously.

3. A search box will appear at the top of the screen. Type Flutter.

4. From the list that appears, click on the option Flutter: New Application Project.

![alt text](image/Practical1_pict1.png)

Explanation: The Command Palette is like a "command center" in VS Code. Instead of hunting through menus, you can directly type any command you need. The Flutter: New Application Project command comes from the Flutter extension and is designed to create the entire basic folder and file structure needed for a Flutter app.

### Step 2: Select the Project Location

Now, Flutter needs to know where you want to save all the files for this new project.

1. After selecting "New Application Project", a file explorer window will open.

2. Navigate to the location where you usually save your coursework, for example, Documents/Practicals or another easy-to-find folder.

3. Do not enter an existing project folder. Simply select the "parent" folder where your new project will be created.

4. Click the "Select a folder to create the project in" button.

![alt text](image/Practical1_pict2.png)

Explanation: 📁 It's good practice to choose a neat and not-too-deep file path (e.g., C:\Users\YourName\Documents\…) to avoid potential issues with long path names, which can sometimes cause errors on certain operating systems.

### Step 3: Name Your Project
Every project needs a unique name as an identifier.

After selecting the folder, VS Code will prompt you to enter a project name.

Type hello_world and press Enter.

Important Rules for Project Names:

Use only lowercase letters.

Use underscores (_) instead of spaces.

The name cannot start with a number or a special character.

![alt text](image/Practical1_pict3.png)

Explanation: 📝 These naming rules are mandatory because the project name is also used as the package name in the Dart/Flutter ecosystem. After you press Enter, Flutter will start working in the background, creating the hello_world folder and populating it with all the necessary template files. This process might take a few seconds to a minute.

### Step 4: Project Successfully Created
If all steps were done correctly, VS Code will open a new window containing your complete Flutter project.

You will see:

The project's folder structure in the panel on the left (containing folders like lib, android, ios, etc.).

The lib/main.dart file will be automatically opened in the main editor.

A success message will appear in the bottom-right corner.

![alt text](image/Practical1_pict4.png)

Explanation: ✅ Congratulations! You have successfully created your first Flutter project. The main.dart file inside the lib folder is the starting point of your application. This is where the code for the default demo app (a simple counter app) is located.

## Practical 2: Connecting an Android Device or Emulator

Continuing from lab 1, you'll be asked to run the application on a physical device (Android or iOS). Please follow the steps in the codelab linked below.

https://developer.android.com/codelabs/basic-android-kotlin-compose-connect-device?hl=en#0

### Step 1. Enable USB Debugging on Your Device 📱
First, you need to unlock a hidden settings menu called Developer Options on your Android device.

Open your device's Settings app and scroll down to About phone.

Find the Build number and tap it seven times in a row. You'll see a message that says, "You are now a developer!"

Go back to the main Settings screen, then navigate to System > Developer options.

Inside Developer options, find the USB debugging toggle and turn it on. You may need to accept a confirmation prompt.

![alt text](image/Practical2_pict1.jpg)

![alt text](image/Practical2_pict2.jpg)

### Srep2. Running Your App on an Android Device with a Cable
After you have enabled USB Debugging on your device, follow these steps:

1.Connect Your Device 🔌
Connect your Android phone or tablet to your computer using a USB cable.

2.Allow USB Debugging
On your Android device's screen, a pop-up dialog with the title "Allow USB debugging?" will appear.

Check the box for "Always allow from this computer" (so you w3.on't be asked again every time you connect this device).

Tap OK.

3.Select the Device in Android Studio
Back in Android Studio on your computer, look at the toolbar at the top. Make sure your device's name appears and is selected in the target device dropdown menu.

(On newer versions of Android Studio, your device is often selected automatically once connected).

4. Run the App ▶️
Click the Run 'app' icon (the green triangle button) to start the process.

Android Studio will then automatically build, install, and launch your application on the connected device.

![alt text](image/Practical2_pict3.png)

### Step 3 Running Your App on an Android Device Using a Cable
Here are the structured, easy-to-follow steps:

1. Connect Your Device to the Computer 🔌
Use a USB cable to connect your Android device to your computer or laptop.

2.Allow USB Debugging on Your Device
After connecting, a dialog box will appear on your Android device's screen asking for permission.

Check the box for "Always allow from this computer". This is useful so you don't have to repeat this step later.

Tap OK.

3.Select the Device in Android Studio
Go back to the Android Studio screen on your computer. In the top toolbar, make sure your device's name is selected in the dropdown menu.

4.Run the App ▶️
Click the Run 'app' icon (the green triangle button) to start the process.

After you click the Run button, Android Studio will automatically install the application onto your device and then launch it.
![alt text](image/Practical2_pict4.png)

### Step 4 Pairing Your Device
Once the prerequisites are met, follow these steps to connect your device to Android Studio.

1.Start Pairing in Android Studio
In the Android Studio toolbar, open the device drop-down menu and select Pair Devices Using Wi-Fi.

2.Enable Wireless Debugging on Your Device

- On your Android device, go to Settings > System > Developer options.

- Scroll down to the "Debugging" section and turn on the Wireless debugging toggle.

- A pop-up will ask for permission. Tap Allow.
![alt text](image/Practical2_pict6.jpg)
3.Connect Using a Code
In the "Wireless debugging" screen on your device, you'll see two options. Choose one:

4.QR Code: Tap Pair device with QR code on your phone and scan the QR code that appears in the Android Studio dialog.

Pairing Code: Tap Pair device with pairing code on your phone. A 6-digit code will appear. Type this code into the dialog in Android Studio.


5.Run the App ▶️
Once your device is successfully paired, it will appear in the device list. You can now click the Run button in Android Studio to deploy your app to the device over Wi-Fi.

![alt text](image/Practical2_pict5.png)