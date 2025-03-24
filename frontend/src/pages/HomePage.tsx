import React, { useState } from 'react'
import HomeTabs from '../components/HomeTabs'
import TrendTab from './TrendTab'
import FollowerTab from './FollowerTab'

function HomePage() {
  const [activeTab, setActiveTab] = useState<'trend' | 'followers'>('trend')

  return (
    <div>
      <h1>ホーム</h1>
      <HomeTabs activeTab={activeTab} onChangeTab={setActiveTab} />

      {activeTab === 'trend' && <TrendTab />}
      {activeTab === 'followers' && <FollowerTab userId={1} />}
    </div>
  )
}

export default HomePage
