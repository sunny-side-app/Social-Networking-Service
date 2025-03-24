import React from 'react'

interface HomeTabsProps {
  activeTab: 'trend' | 'followers'
  onChangeTab: (tab: 'trend' | 'followers') => void
}

function HomeTabs({ activeTab, onChangeTab }: HomeTabsProps) {
  return (
    <div style={{ marginBottom: '1rem' }}>
      <button
        onClick={() => onChangeTab('trend')}
        style={{ fontWeight: activeTab === 'trend' ? 'bold' : 'normal' }}
      >
        トレンド
      </button>
      <button
        onClick={() => onChangeTab('followers')}
        style={{ fontWeight: activeTab === 'followers' ? 'bold' : 'normal' }}
      >
        フォロー中
      </button>
    </div>
  )
}

export default HomeTabs
