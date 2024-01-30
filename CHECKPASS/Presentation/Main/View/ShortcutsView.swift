//
//  ShortcutsView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/25/24.
//

import SwiftUI

struct ShortcutsView: View {
    @State private var showHomePage: Bool = false
    @State private var showSchedule: Bool = false
    @State private var showNotice: Bool = false
    @State private var showPortalSystem: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: UIScreen.main.bounds.width * 0.2)
                .foregroundColor(.white)
                .shadow(radius: 2)
            
            HStack(spacing: UIScreen.main.bounds.width * 0.12) {
                Button(action: {
                    showHomePage.toggle()
                }, label: {
                    ShortcutIcon(image: "rocket", caption: "홈페이지")
                        .foregroundColor(.black)
                })
                
                Button(action: {
                    showSchedule.toggle()
                }, label: {
                    ShortcutIcon(image: "calender", caption: "학사일정")
                        .foregroundColor(.black)
                })
                
                Button(action: {
                    showNotice.toggle()
                }, label: {
                    ShortcutIcon(image: "megaphone", caption: "학사공지")
                        .foregroundColor(.black)
                })
                
                Button(action:{
                    showPortalSystem.toggle()
                }, label: {
                    ShortcutIcon(image: "puzzle", caption: "통합정보")
                        .foregroundColor(.black)
                })
            }
        }
        .navigationDestination(isPresented: $showHomePage, destination: {
            WebBrowserView("https://www.ut.ac.kr/kor.do", showWebPage: $showHomePage)
        })
        .navigationDestination(isPresented: $showSchedule, destination: {
            WebBrowserView("https://www.ut.ac.kr/prog/schedule/kor/sub05_01/1/scheduleList.do", showWebPage: $showSchedule)
        })
        .navigationDestination(isPresented: $showNotice, destination: {
            WebBrowserView("https://www.ut.ac.kr/cop/bbs/BBSMSTR_000000000055/selectBoardList.do", showWebPage: $showNotice)
        })
        .navigationDestination(isPresented: $showPortalSystem, destination: {
            WebBrowserView("https://sso.ut.ac.kr/svc/tk/Auth.eps?ac=Y&ifa=N&id=portal&", showWebPage: $showPortalSystem)
        })
    }
}

#Preview {
    ShortcutsView()
}
