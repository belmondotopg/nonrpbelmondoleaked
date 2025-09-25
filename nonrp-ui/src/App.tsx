// import { Binds } from "./components/binds";
import { Chat } from "./components/chat";
import { Binds } from "./components/binds";
import { RadioList } from "./components/radio-list";
import { Scoreboard } from "./components/scoreboard";

export default function App () {
    return (
        <>
            <Scoreboard />
            <RadioList />
            <Chat />
            <Binds />
        </>
    )
}