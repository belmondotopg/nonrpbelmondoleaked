import { useEffect, useState } from "react";
import { Logo } from "./logo";
import { cn } from "../lib/utils";

interface ScoreboardDataStatProps {
    label: string;
    value: string | number;
}

export const ScoreboardDataStat = ({ label, value }: ScoreboardDataStatProps) => {
    return (
        <div className="flex justify-between items-center w-full ">
            <p className="text-sm font-light text-white">{label}</p>
            <div className="text-sm font-semibold text-primary">{value}</div>
        </div>
    );
};

interface ScoreboardData {
    players: number;
    admins: number;
    gameTime: string;
    police: number;
    firstJob: string;
}

export const Scoreboard = () => {
    const [show, setShow] = useState(true);
    const [data, setData] = useState<ScoreboardData>(
        {
            players: 0,
            admins: 0,
            gameTime: "0h 0m",
            police: 0,
            firstJob: "Brak"
        }
    );

    useEffect(() => {
        interface MessageData {
            eventName: "nui:scoreboard:update";
            show?: boolean;
            data?: ScoreboardData;
        }

        const onMessage = ({ data }: MessageEvent<MessageData>) => {
            if (data.eventName === "nui:scoreboard:update") {
                if (data.show !== undefined) {
                    setShow(data.show);
                }

                if (data.data !== undefined) {
                    setData(data.data);
                }
            }
        };

        window.addEventListener("message", onMessage);

        return () => window.removeEventListener("message", onMessage);
    }, []);

    return (
        <>
            {data && (
                <div
                    className={cn(
                        "fixed right-[15px] top-1/2 transform -translate-y-1/2 w-[350px] origin-right bg-custom-black/80 text-white rounded-lg shadow-lg transition-all",
                        !show && "opacity-0 scale-0"
                    )}
                >
                    <div className="p-4">
                        <div className="flex items-center justify-between mb-4">
                            <div className="flex items-center gap-2">
                                <Logo size={40} />
                            <div className="text-xs text-gray-400">
                                <h1 className="text-lg font-bold tracking-wider text-white">NonRP</h1>
                                <span>discord.gg/nonrp</span>
                            </div>
                            </div>
                        </div>

                        <div className="mb-6">
                        <p className="text-sm font-medium text-gray-400 mb-2">INFORMACJE</p>
                            <ScoreboardDataStat label="Liczba graczy" value={`${data.players}`} />
                            <ScoreboardDataStat label="Twój czas gry" value={data.gameTime} />
                        </div>

                        <div className="mb-6">
                            <p className="text-sm font-medium text-gray-400 mb-2">FRAKCJE</p>
                            <ScoreboardDataStat label="SASP" value={`${data.police}`} />
                            <ScoreboardDataStat label="ADM" value={`${data.admins}`} />
                        </div>

                        <div>
                            <p className="text-sm font-medium text-gray-400 mb-2">ZATRUDNIENIE</p>
                            <ScoreboardDataStat label="Pierwsza praca" value={data.firstJob} />
                        </div>
                    </div>
                </div>
            )}
        </>
    );
};
