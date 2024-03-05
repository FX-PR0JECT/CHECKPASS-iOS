//
//  ShortcutsScrollView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/23/24.
//

import SwiftUI

struct ShortcutsScrollView: View {
    @State private var showHomePage: Bool = false
    @State private var showSchedule: Bool = false
    @State private var showNotice: Bool = false
    @State private var showPortalSystem: Bool = false
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button(action: {
                    showHomePage.toggle()
                }, label: {
                    ShortcutCard(for: .homepage,
                                 background: Color(red: 249 / 255, green: 136 / 255, blue: 102 / 255),
                                 textColor: Color(red: 255 / 255, green: 242 / 255, blue: 215 / 255),
                                 imageName: "rocket")
                })
                
                Button(action: {
                    showSchedule.toggle()
                }, label: {
                    ShortcutCard(for: .schedule,
                                 background: Color(red: 161 / 255, green: 190 / 255, blue: 149 / 255),
                                 textColor: Color(red: 44 / 255, green: 95 / 255, blue: 45 / 255),
                                 imageName: "calender")
                })
                
                Button(action: {
                    showNotice.toggle()
                }, label: {                    
                    ShortcutCard(for: .notice,
                                 background: Color(red: 196 / 255, green: 223 / 255, blue: 230 / 255),
                                 textColor: Color(red: 102 / 255, green: 165 / 255, blue: 173 / 255),
                                 imageName: "megaphone")
                })
                
                Button(action:{
                    showPortalSystem.toggle()
                }, label: {
                    ShortcutCard(for: .system,
                                 background: Color(red: 211 / 255, green: 197 / 255, blue: 229 / 255),
                                 textColor: Color(red: 115 / 255, green: 93 / 255, blue: 165 / 255),
                                 imageName: "puzzle")
                })
                
                
            }
            .buttonStyle(.borderless)
            .padding()
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
    ShortcutsScrollView()
}
